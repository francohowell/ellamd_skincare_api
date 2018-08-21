# == Schema Information
#
# Table name: prescriptions
#
#  id                        :integer          not null, primary key
#  physician_id              :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  token                     :string
#  signa                     :text             default(""), not null
#  customer_instructions     :text             default(""), not null
#  pharmacist_instructions   :text             default(""), not null
#  tracking_number           :text
#  fragrance                 :string
#  cream_base                :string
#  volume_in_ml              :integer          default(15), not null
#  formulation_id            :integer
#  fulfilled_at              :datetime
#  visit_id                  :integer
#  not_downloaded_alerted_at :datetime
#  no_tracking_alerted_at    :datetime
#  is_copy                   :boolean          default(FALSE), not null
#

##
# A Prescription is a Physician-created prescription of a skincare routine to a Customer.
#
# Prescriptions are one of the main components of the app. They are created by Physicians, viewed
# by Customers, and downloaded and fulfilled by Pharmacists. The Prescription model encapsulates
# PDF generation for the pharmacy, and more.
class Prescription < ApplicationRecord
  MAGIC_TRACKING_NUMBER = '123'

  include HasToken
  include HasIngredientsAndAmounts

  ##
  # The fragrance options for the product.
  FRAGRANCES = ["no_scent", "rose_hip", "eucalyptus"].freeze

  ##
  # The cream base options for the product.
  CREAM_BASES = ["hrt", "anhydrous"].freeze

  belongs_to :formulation, inverse_of: :prescriptions
  belongs_to :physician,   inverse_of: :prescriptions
  belongs_to :visit,       inverse_of: :prescription

  has_many :prescription_ingredients, inverse_of: :prescription, dependent: :destroy

  has_one :customer, through: :visit
  has_many :ingredients, through: :prescription_ingredients

  accepts_nested_attributes_for :prescription_ingredients

  validates :visit, presence: true
  validates :physician, presence: true
  validates :prescription_ingredients, presence: true
  validates :cream_base, inclusion: {in: CREAM_BASES}
  validates :fragrance, inclusion: {in: FRAGRANCES}
  validates :tracking_number, tracking_number: { except: MAGIC_TRACKING_NUMBER }, allow_nil: true
  validates :volume_in_ml, numericality: {greater_than: 0}

  scope :incoming,   -> { where(fulfilled_at: nil) }
  scope :processing, -> { where.not(fulfilled_at: nil).where(tracking_number: nil) }
  scope :filled,     -> { where.not(tracking_number: nil) }

  scope :not_downloaded_in_1_day, -> { where("CURRENT_TIMESTAMP - created_at >= INTERVAL '24 hours' AND fulfilled_at IS NULL") }
  scope :not_alerted_about_download, -> { where("not_downloaded_alerted_at IS NULL") }
  scope :not_shipped_in_2_days, -> { where("tracking_number IS NULL AND CURRENT_TIMESTAMP - fulfilled_at >= INTERVAL '48 hours'") }
  scope :not_alerted_about_shipping, -> { where("no_tracking_alerted_at IS NULL") }

  ##
  # Format the filename for the Prescription's PDF, including the Prescription's creation time and
  # the Customer's name.
  def pdf_filename
    "EllaMD_RX_#{customer.identity.first_name}_#{customer.identity.last_name}_" +
      created_at.strftime("%Y%m%d")
  end

  ##
  # Find a Formulation which matches this Prescription's Ingredients and amounts.
  #
  # TODO: We should be storing the Formulation of a Prescription alongside the Prescription's other
  #   fields instead of figuring it out on the fly here. The specifications around matching
  #   Formulations with Prescriptions have been changing a bit (e.g. whether or not the amounts
  #   must match), so once that has stabilized, this can be refactored.
  def computed_formulation
    Formulation.includes(formulation_ingredients: :ingredient).each do |formulation|
      # We compare the rendered Ingredients strings to see if the Formulation matches.
      return formulation if ingredients_string == formulation.ingredients_string
    end

    nil
  end

  ##
  # Is the Prescription fulfilled?
  def fulfilled?
    # Because we don't integrate with the pharmacy in any way, we assume that the Prescription is
    # being fulfilled as soon as it is downloaded.
    !fulfilled_at.nil?
  end

  ##
  # Should this Prescription be shown to Pharmacists for fulfillment?
  def should_show_to_pharmacists?
    # HACK: This is a super hacky, stopgap solution to stop showing old prescriptions to the new
    #   pharmacy as of 12 Nov 2017. This is a terrible, terrible way to do this and should be
    #   fixed at some point.
    return false if fulfilled? && fulfilled_at < Date.new(2017, 11, 15)

    # We show already-fulfilled Prescriptions to the Pharmacists (so that they can re-download
    # them, add tracking, etc.), and we show paid and free Prescriptions so they can be fulfilled.
    fulfilled? || !visit.has_to_be_paid?
  end

  ##
  # Gets a tracking url based on prescription tracking_number
  def tracking_url
    return unless tracking_number

    tracking = TrackingNumber.new(tracking_number)

    return unless tracking.valid?

    case tracking.carrier
    when :ups
      "https://wwwapps.ups.com/WebTracking/processInputRequest?loc=en_US&tracknum=#{tracking_number}"
    when :usps
      "http://trkcnfrm1.smi.usps.com/PTSInternetWeb/InterLabelInquiry.do?origTrackNum=#{tracking_number}"
    when :fedex
      "https://www.fedex.com/apps/fedextrack/?action=track&trackingnumber=#{tracking_number}"
    else
      raise StandardError, "Carrier #{tracking.carrier} is not supported yet"
    end
  end

  ##
  # Mark the Prescription as fulfilled if it isn't already.
  def mark_as_fulfilled
    return unless fulfilled_at.nil?
    update!(fulfilled_at: Time.current)
  end

  def build_copy
    new_prescription = Prescription.new(
      physician_id: physician_id,
      signa: signa,
      customer_instructions: customer_instructions,
      pharmacist_instructions: pharmacist_instructions,
      fragrance: fragrance,
      cream_base: cream_base,
      volume_in_ml: volume_in_ml,
      formulation_id: formulation_id,
      is_copy: true
    )

    prescription_ingredients.each do |pi|
      new_prescription.prescription_ingredients.build(
        ingredient_id: pi.ingredient_id,
        amount: pi.amount
      )
    end

    new_prescription
  end
end
