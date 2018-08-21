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

class FormulationIngredientSerializer < ApplicationSerializer
  attribute :id
  attribute :amount

  belongs_to :ingredient
  always_include :ingredient
end
