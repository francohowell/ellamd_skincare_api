# == Schema Information
#
# Table name: formulation_ingredients
#
#  id             :integer          not null, primary key
#  formulation_id :integer
#  ingredient_id  :integer
#  amount         :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

##
# A FormulationIngredient joins a Formulation with an amount of an Ingredient.
class FormulationIngredient < ApplicationRecord
  include ValidatesIngredientAmount

  belongs_to :formulation, inverse_of: :formulation_ingredients
  belongs_to :ingredient,  inverse_of: :formulation_ingredients

  validates :formulation, presence: true
  validates :ingredient,  presence: true, uniqueness: {scope: :formulation}
end
