module V2
  class RegimenProductSerializer
    attr_reader :regimen_product, :mode

    # Serialization modes: [:complete]
    def initialize(regimen_product, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @regimen_product = regimen_product
      @mode = mode
    end

    def as_json
      return nil if regimen_product.nil?

      {
        "id" => regimen_product.id,
        "period" => regimen_product.period,
        "position" => regimen_product.position,

        "product" => V2::ProductSerializer.new(regimen_product.product, mode: mode).as_json,
      }
    end
  end
end





