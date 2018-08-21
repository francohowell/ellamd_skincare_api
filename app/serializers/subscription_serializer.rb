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

class SubscriptionSerializer < ApplicationSerializer
  attribute :id
  attribute :status
  attribute :stripe_customer_id
  attribute :stripe_subscription_id
  attribute :stripe_coupon_id
  attribute :next_visit_at
  attribute :next_charge_at
  attribute :initial_treatment_plan_is_free
  attribute :has_payment_source
  attribute :needs_treatment_plan
  attribute :needs_profile_update
end
