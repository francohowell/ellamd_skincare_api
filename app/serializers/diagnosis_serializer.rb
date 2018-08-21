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

class DiagnosisSerializer < ApplicationSerializer
  attribute :id
  attribute :note
  attribute :created_at

  belongs_to :physician

  has_many :diagnosis_conditions
  always_include :diagnosis_conditions
end
