module V2
  class ProductIngredientSerializer
    attr_reader :product_ingredient, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(product_ingredient, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @product_ingredient = product_ingredient
      @mode = mode
    end

    def as_json
      return nil if product_ingredient.nil?

      {
        "id" => product_ingredient.id,
        "name" => product_ingredient.name,
        "is-key" => product_ingredient.is_key,

        "created-at" => product_ingredient.created_at,
        "updated-at" => product_ingredient.updated_at,
      }
    end
  end
end







