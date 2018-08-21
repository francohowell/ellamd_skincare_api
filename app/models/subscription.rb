# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  status                         :integer          default("inexistent"), not null
#  customer_id                    :integer          not null
#  stripe_subscription_id         :string
#  next_visit_at                  :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  stripe_customer_id             :string
#  initial_treatment_plan_is_free :boolean          default(FALSE), not null
#  stripe_coupon_id               :string
#  needs_treatment_plan           :boolean          default(TRUE), not null
#  has_payment_source             :boolean          default(FALSE), not null
#  next_charge_at                 :datetime
#  needs_profile_update           :boolean          default(FALSE), not null
#

class Subscription < ApplicationRecord
  # TODO: This should be pulled from the Stripe subscription plan.
  TIME_BETWEEN_VISITS = 2.days
  WINDOW_BETWEEN_VISIT_AND_PAYMENT = 1.day
  LATE_WINDOW = 1.day
  FOREVER_TRIAL_PERIOD = 1.year

  belongs_to :customer, inverse_of: :subscription

  has_many :visits, through: :customer

  enum status: {
    inexistent: 0,
    active:     1,
    unpaid:     2,
    paused:     3,
    cancelled:  4
  }

  validates :customer, presence: true

  scope :with_upcoming_visit, -> { active.where("subscriptions.next_visit_at < ?", Time.now) }

  before_create -> { self.next_charge_at = Time.now }

  def current_visit
    visits.reorder("id DESC").first
  end

  def action_is_required_from_customer_or_physician?
    needs_profile_update? || needs_treatment_plan?
  end

  def start
    stripe_params = {
      customer: stripe_customer_id,
      items: [{plan: Figaro.env.stripe_plan_id!}],
      metadata: {environment: Figaro.env.environment}
    }

    if action_is_required_from_customer_or_physician?
      self.status = :paused
      stripe_params[:trial_end] = (Time.now + FOREVER_TRIAL_PERIOD).to_i
    elsif next_charge_at.future?
      self.status = :active
      stripe_params[:trial_end] = next_charge_at.to_i
    else
      self.status = :active
      self.next_charge_at = Time.now
    end

    stripe_subscription = Stripe::Subscription.create(stripe_params)

    self.stripe_subscription_id = stripe_subscription.id
    save!
  end

  def unblock_with_profile_update(medical_profile_changes)
    self.needs_profile_update = false

    if medical_profile_changes.present?
      require_new_treatment_plan
    elsif paused? && !action_is_required_from_customer_or_physician?
      unpause
    end

    save!
  end

  def unblock_with_treatment_plan
    self.needs_treatment_plan = false
    self.needs_profile_update = false

    unpause(eligible_for_late_window: false) if paused?
    save!
  end

  def pause
    raise "Attempt to pause non-active Subscription ##{id}" unless active?

    stripe_subscription.trial_end = (Time.now + FOREVER_TRIAL_PERIOD).to_i
    stripe_subscription.prorate = false
    stripe_subscription.save

    self.status = :paused
    save!
  end

  def unpause(eligible_for_late_window: true)
    raise "Attempt to unpause non-paused Subscription ##{id}" unless paused?

    late_window = Time.now + LATE_WINDOW

    trial_end = if eligible_for_late_window && late_window > next_charge_at
                  late_window.to_i
                elsif next_charge_at.future?
                  next_charge_at.to_i
                else
                  'now'
                end

    stripe_subscription.trial_end = trial_end
    stripe_subscription.save

    self.status = :active
    save!
  end

  def cancel
    raise "Attempt to cancel inactive Subscription ##{id}" unless active? || paused? || unpaid?
    if stripe_subscription_id.blank?
      raise "Active Subscription ##{id} does not have :stripe_subscription_id set"
    end

    stripe_subscription.delete

    self.stripe_subscription_id = nil
    self.next_visit_at = nil
    self.status = :cancelled
    save!
  end

  def mark_as_active
    return if active?

    if unpaid?
      self.status = :active
      save!
    else
      raise "Payment succeeded for inactive Subscription ##{id}"
    end
  end

  def mark_as_unpaid
    return if unpaid?

    if active?
      self.status = :unpaid
      self.has_payment_source = false
      save!
    else
      raise "Payment failed for inactive Subscription ##{id}"
    end
  end

  def update_card(stripe_token:)
    stripe_customer.source = stripe_token
    stripe_customer.save

    self.has_payment_source = true
    save!
  end

  def apply_coupon(coupon:)
    stripe_customer.coupon = coupon
    stripe_customer.save

    self.stripe_coupon_id = coupon
    save!
  end


  def require_new_treatment_plan
    self.needs_treatment_plan = true
    pause if active?
    save!
  end

  # TODO: create stripe customer during Customer.create process
  #       and add non-null constraint to stripe_customer_id column
  def stripe_customer
    @stripe_customer ||= if stripe_customer_id
                           Stripe::Customer.retrieve(stripe_customer_id)
                         else
                           stripe_customer = Stripe::Customer.create(email: customer.email)
                           update!(stripe_customer_id: stripe_customer.id)
                           stripe_customer
                         end
  end

  private def stripe_subscription
    @stripe_subscription ||= if stripe_subscription_id
                               Stripe::Subscription.retrieve(stripe_subscription_id)
                             else
                               nil
                             end
  end
end
