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

##
# A DiagnosisCondition joins a Diagnosis with a Condition.
class DiagnosisCondition < ApplicationRecord
  belongs_to :diagnosis, inverse_of: :diagnosis_conditions
  belongs_to :condition, inverse_of: :diagnosis_conditions

  validates :condition, presence: true, uniqueness: {scope: :diagnosis}
end
