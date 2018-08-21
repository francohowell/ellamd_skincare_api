# == Schema Information
#
# Table name: diagnosis_conditions
#
#  id           :integer          not null, primary key
#  diagnosis_id :integer
#  condition_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :text
#

class DiagnosisConditionSerializer < ApplicationSerializer
  attribute :id
  attribute :description

  belongs_to :condition
  always_include :condition
end
