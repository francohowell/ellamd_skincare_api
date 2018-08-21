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

class PrescriptionIngredientSerializer < ApplicationSerializer
  attribute :id
  attribute :amount

  belongs_to :ingredient
  always_include :ingredient
end
