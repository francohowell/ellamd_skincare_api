module V2
  class FormulationSerializer
    attr_reader :formulation, :mode

    # Serialization modes: [:complete]
    def initialize(formulation, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @formulation = formulation
      @mode = mode
    end

    def as_json
      return nil if formulation.nil?

      {
        "id" => formulation.id,
        "number" => formulation.number,
        "main-tag" => formulation.main_tag,
        "cream-base" => formulation.cream_base,

        "formulation-ingredients" => formulation_ingredient_hashes,
      }
    end

    private def formulation_ingredient_hashes
      formulation.formulation_ingredients
                 .map { |fi| V2::FormulationIngredientSerializer.new(fi, mode: mode).as_json }
    end
  end
end

