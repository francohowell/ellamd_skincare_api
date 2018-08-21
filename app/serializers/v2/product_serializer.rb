module V2
  class ProductSerializer
    attr_reader :product, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(product, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @product = product
      @mode = mode
    end

    # Attributes not included in the list:
    # -  origin_id
    # -  raw
    def as_json
      return nil if product.nil?

      {
        "id" => product.id,
        "store-id" => product.store_id,
        "store" => product.store,

        "brand" => product.brand,
        "name" => product.name,

        "description" => product.description,
        "diagnoses" => product.diagnoses,
        "instructions" => product.instructions,
        "image-url" => product.image_url,
        "product-url" => product.product_url,
        "tags" => product.tags,
        "packages" => product.packages,
        "average-rating" => product.average_rating,
        "number-of-reviews" => product.number_of_reviews,
        "is-pending" => product.is_pending,

        "created-at" => product.created_at,
        "updated-at" => product.updated_at,

        "product-ingredients" => product_ingredients_hashes,
      }
    end

    private def product_ingredients_hashes
      product.product_ingredients
             .map { |pi| V2::ProductIngredientSerializer.new(pi, mode: mode).as_json }

    end
  end
end
