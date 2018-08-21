##
# Concern to validate that Ingredient amounts are appropriate.
#
# Both Formulations and Prescriptions have Ingredients and amounts of those Ingredients. The amounts
# must fall between the Ingredient's minimum and maximum amounts, and this validation checks for
# that.
module ValidatesIngredientAmount
  extend ActiveSupport::Concern

  included do
    validates :amount, numericality: {
      greater_than_or_equal_to: ->(fi) { fi.ingredient&.minimum_amount || 0 },
      less_than_or_equal_to: ->(fi) { fi.ingredient&.maximum_amount || BigDecimal.new("Infinity") },
      message: ->(fi, data) {
        "of #{fi.ingredient&.name} must be between " \
          "#{fi.ingredient&.minimum_amount || 0} and " \
          "#{fi.ingredient&.maximum_amount || BigDecimal.new('Infinity')}" \
          "#{fi.ingredient&.unit}. You entered #{data[:value]}#{fi.ingredient&.unit}."
      },
    }
  end
end
