# == Schema Information
#
# Table name: diagnoses
#
#  id           :integer          not null, primary key
#  physician_id :integer
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  visit_id     :integer
#

##
# A Diagnosis is a Physician-provided diagnosis of a Customer.
#
# The relationship between Diagnoses and Prescriptions is a little confusing. Right now, Diagnoses
# are basically just additional information provided to the Customer, but a Prescription is what
# gets ordered, tracked, etc.
class Diagnosis < ApplicationRecord
  belongs_to :physician, inverse_of: :diagnoses
  belongs_to :visit,     inverse_of: :diagnosis

  has_many :diagnosis_conditions, inverse_of: :diagnosis, dependent: :destroy

  has_one  :customer,   through: :visit
  has_many :conditions, through: :diagnosis_conditions

  accepts_nested_attributes_for :diagnosis_conditions

  validates :physician, presence: true
  validates :visit,     presence: true
end
