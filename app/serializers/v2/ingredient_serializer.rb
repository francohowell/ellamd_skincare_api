module V2
  class IngredientSerializer
    attr_reader :ingredient, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(ingredient, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @ingredient = ingredient
      @mode = mode
    end

    def as_json
      return nil if ingredient.nil?

      {
        "id" => ingredient.id,

        "name" => ingredient.name,
        "minimum-amount" => ingredient.minimum_amount,
        "maximum-amount" => ingredient.maximum_amount,
        "unit" => ingredient.unit,
        "description" => ingredient.description,
      }
    end
  end
end

