module V2
  class FormulationIngredientSerializer
    attr_reader :formulation_ingredient, :mode

    # Serialization modes: [:complete]
    def initialize(formulation_ingredient, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @formulation_ingredient = formulation_ingredient
      @mode = mode
    end

    def as_json
      return nil if formulation_ingredient.nil?

      {
        "id" => formulation_ingredient.id,
        "amount" => formulation_ingredient.amount,
        "ingredient" => V2::IngredientSerializer.new(formulation_ingredient.ingredient, mode: mode).as_json,
      }
    end
  end
end
