# == Schema Information
#
# Table name: formulations
#
#  id         :integer          not null, primary key
#  number     :integer
#  main_tag   :text
#  cream_base :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# A Formulation is like a preset for a Prescription.
#
# Formulations are essentially the same as Prescriptions, but they are not assigned to a Customer
# nor are they prescribed directly by a Physician. Rather, they contain some metadata (a `name`, a
# `number`, etc.) and serve as presets for the Physician-created Prescriptions.
class Formulation < ApplicationRecord
  include HasIngredientsAndAmounts

  default_scope { order(number: :asc) }

  has_many :formulation_ingredients, inverse_of: :formulation, dependent: :destroy
  has_many :prescriptions,           inverse_of: :formulation

  has_many :ingredients, through: :formulation_ingredients

  validates :number,     uniqueness: true
  validates :main_tag,   presence: true
  validates :cream_base, inclusion: {in: Prescription::CREAM_BASES}
  validates :formulation_ingredients, presence: true
end
