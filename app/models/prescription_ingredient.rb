# == Schema Information
#
# Table name: prescription_ingredients
#
#  id              :integer          not null, primary key
#  prescription_id :integer
#  ingredient_id   :integer
#  amount          :float            default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

##
# A PrescriptionIngredient joins a Prescription with an amount of an Ingredient.
class PrescriptionIngredient < ApplicationRecord
  include ValidatesIngredientAmount

  AMOUNT_PRECISION = 3

  belongs_to :prescription, inverse_of: :prescription_ingredients
  belongs_to :ingredient,   inverse_of: :prescription_ingredients

  validates :ingredient, presence: true
  validates :ingredient, uniqueness: {scope: :prescription}
end
