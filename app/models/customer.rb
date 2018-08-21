# == Schema Information
#
# Table name: customers
#
#  id                      :integer          not null, primary key
#  physician_id            :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  address_line_1          :string
#  address_line_2          :string
#  zip_code                :string
#  state                   :string
#  city                    :string
#  phone                   :string
#  archived_at             :datetime
#  last_onboarding_step    :integer          default(1), not null
#  onboarding_completed_at :datetime
#

##
# A Customer is a user who gets prescribed and then purchases skincare products.
#
# Customers are our end users. They're the members of the public who are using the application (in
# contrast with Administrators, Physicians, and Pharmacists, who are manually onboarded by the
# team).
class Customer < ApplicationRecord
  include HasIdentity
  include ValidatesProfile
  include ReceivesReminderEmails

  audited

  default_scope { where(archived_at: nil).order(id: :asc) }

  belongs_to :physician, inverse_of: :customers

  has_one  :subscription,    inverse_of: :customer, dependent: :destroy
  has_one  :medical_profile, inverse_of: :customer, dependent: :destroy
  has_many :visits,          inverse_of: :customer, dependent: :destroy
  has_many :photos,          inverse_of: :customer, dependent: :destroy
  has_many :regimens,        inverse_of: :customer, dependent: :destroy
  has_many :messages,        inverse_of: :customer, dependent: :destroy
  has_many :prescriptions, through: :visits
  has_many :diagnoses,     through: :visits

  has_one  :actual_regimen,
           -> { where("regimens.visit_id IS NULL") },
           inverse_of: :customer,
           class_name: "Regimen"

  scope :has_visit_photos, -> { includes(visits: :photos).where.not(photos: { id: nil }) }
  scope :profile_complete, -> { where.not(zip_code: nil) }
  scope :with_messages, -> { includes(:messages).where.not(messages: { id: nil }) }
  scope :needs_prescription, -> {
    # TODO: select only Customers whose Subscription status is:
    #         - active
    #         - paused
    #         - inexistent but with a free treatment plan
    with_photos_without_prescription_condition = <<~SQL
      EXISTS (SELECT 1 FROM photos
              WHERE photos.customer_id = customers.id
             )
      AND
      EXISTS (SELECT 1 FROM subscriptions
              WHERE subscriptions.customer_id = customers.id
                AND subscriptions.needs_treatment_plan IS TRUE
                AND subscriptions.needs_profile_update IS FALSE
                AND subscriptions.next_charge_at < :now
             )
    SQL

    profile_complete.where(with_photos_without_prescription_condition, now: Time.now)
  }

  validates :physician, presence: true

  before_create :build_medical_profile
  before_create :build_subscription
  before_create -> { visits.build }
  before_create -> { regimens.build }

  # We use Phony to normalize the Customer's phone number.
  phony_normalize :phone

  ##
  # A helper function to grab the Customer's current (latest) Visit.
  def current_visit
    visits.reorder("id DESC").first
  end

  ##
  # Render a string containing the Customer's full name and creation date
  def physician_daily_email_link_html
    # TODO: This sort of rendering/formating doesn't belong here.
    label = "(#{created_at.strftime("%Y-%m-%d")}) " \
      "#{first_name} #{last_name}: #{photos.count} photos"
    url = "https://my.ellamd.com/customer/#{id}"

    "<a href='#{url}'>#{label}</a>"
  end

  ##
  # Return a Stripe Customer for this Customer.
  #
  # If the Customer has a Stripe Customer associated with him or her already, we fetch and return
  # that Customer. Otherwise one is synchronously created, saved to the Customer, and returned.
  def stripe_customer
    if stripe_customer_id
      Stripe::Customer.retrieve(stripe_customer_id)
    else
      stripe_customer = Stripe::Customer.create(email: email)
      update!(stripe_customer_id: stripe_customer.id)
      stripe_customer
    end
  end

  ##
  # Send the customer a text message requesting photos.
  def send_photo_prompt_text_message
    message = "Hey there, #{first_name}, it's EllaMD! Please respond with (3) " \
      "closeup pictures of your face: Front, Left, and Right. No makeup and good lighting for " \
      "the most accurate diagnosis!"

    send_text_message(message)
  end

  ##
  # Send the customer a text message.
  def send_text_message(message)
    # TODO: This `@twilio_client` should really be a global singleton somewhere, and this should
    #   exist somewhere near the TwilioController functionality.
    @twilio_client = Twilio::REST::Client.new
    @twilio_client.api.account.messages.create(
      from: Figaro.env.twilio_phone!,
      to: phone,
      body: message
    )
  end
end
