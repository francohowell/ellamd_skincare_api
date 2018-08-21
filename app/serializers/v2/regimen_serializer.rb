module V2
  class RegimenSerializer
    attr_reader :regimen, :mode

    # Serialization modes: [:complete]
    def initialize(regimen, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @regimen = regimen
      @mode = mode
    end

    def as_json
      return nil if regimen.nil?

      {
        "id" => regimen.id,
        "physician-id" => regimen.physician_id,
        "created-at" => regimen.created_at,
        "updated-at" => regimen.updated_at,

        "regimen-products" => regimen_products_hashes,
      }
    end

    private def regimen_products_hashes
      regimen.regimen_products
             .map { |rp| V2::RegimenProductSerializer.new(rp, mode: mode).as_json }
    end
  end
end
