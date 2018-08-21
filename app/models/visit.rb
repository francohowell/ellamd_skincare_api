# == Schema Information
#
# Table name: visits
#
#  id                :integer          not null, primary key
#  customer_id       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  payment_status    :integer          default("unpaid"), not null
#  stripe_invoice_id :string
#

##
# A Visit encapsulates Photos, a Regimen, a Diagnosis, and a Prescription into one semantic object.
class Visit < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :customer, inverse_of: :visits

  has_many :photos,      inverse_of: :visit
  has_one :diagnosis,    inverse_of: :visit, dependent: :destroy
  has_one :prescription, inverse_of: :visit, dependent: :destroy
  has_one :regimen,      inverse_of: :visit, dependent: :destroy

  enum payment_status: {
    unpaid: 0,
    paid: 1,
    free: 2,
    unpaid_with_free_treatment_plan: 3
  }

  validates :payment_status, presence: true

  scope :without_prescription, -> { eager_load(:prescription).where(prescriptions: {id: nil}) }
  scope :can_have_rx, -> { where(payment_status: [:paid, :free, :unpaid_with_free_treatment_plan]) }
  scope :waiting_for_rx, -> { can_have_rx.without_prescription } # TODO

  def has_to_be_paid?
    unpaid? || unpaid_with_free_treatment_plan?
  end

  def already_paid?
    paid? || free?
  end

  def has_prescription?
    prescription.present?
  end

  def previous_visit
    Visit.where(customer_id: customer_id)
         .where("id < ?", id)
         .order("id DESC")
         .first
  end

  def pay_with_stripe_invoice(invoice_id)
    if stripe_invoice_id.present? && stripe_invoice_id != invoice_id
      raise "Visit ##{id} has been paid with invoices ##{stripe_invoice_id} and ##{invoice_id}"
    end

    self.stripe_invoice_id = invoice_id
    self.payment_status = :paid
  end

  def copy_previous_prescription
    self.prescription = previous_visit.prescription&.build_copy
  end
end
