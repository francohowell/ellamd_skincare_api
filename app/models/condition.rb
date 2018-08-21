# == Schema Information
#
# Table name: conditions
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

##
# A Condition is a medical condition with which a Customer can be diagnosed.
class Condition < ApplicationRecord
  has_many :diagnosis_conditions, inverse_of: :condition, dependent: :nullify
  has_many :photo_conditions,     inverse_of: :condition

  validates :name, presence: true, uniqueness: true
end
