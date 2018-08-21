module V2
  class PrescriptionIngredientSerializer
    attr_reader :prescription_ingredient, :mode

    # Serialization modes: [:complete]
    def initialize(prescription_ingredient, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @prescription_ingredient = prescription_ingredient
      @mode = mode
    end

    def as_json
      return nil if prescription_ingredient.nil?

      {
        "id" => prescription_ingredient.id,
        "amount" => prescription_ingredient.amount,

        "ingredient" => V2::IngredientSerializer.new(prescription_ingredient.ingredient, mode: mode).as_json
      }
    end
  end
end



