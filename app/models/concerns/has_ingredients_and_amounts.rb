##
# Concern to combine common functionality for Prescriptions and Formulations.
#
# Both Prescriptions and Formulations have Ingredients and amounts of those Ingredients, so we
# combine the functionality around that commonality here.
module HasIngredientsAndAmounts
  extend ActiveSupport::Concern

  ##
  # Render a string containing the Ingredients, their units, and their amounts.
  def ingredients_string
    (is_a?(Prescription) ? prescription_ingredients : formulation_ingredients)
      .sort_by { |pfi| pfi.ingredient.name }
      .map { |pfi| "#{pfi.amount}#{pfi.ingredient.unit} #{pfi.ingredient.name}" }
      .join(", ")
  end
end
