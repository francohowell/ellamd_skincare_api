module V2
  class PrescriptionSerializer
    include Rails.application.routes.url_helpers

    attr_reader :prescription, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(prescription, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @prescription = prescription
      @mode = mode
    end

    def as_json
      return nil if prescription.nil?

      case mode
      when :basic    then as_json_basic
      when :complete then as_json_complete
      end
    end

    private def as_json_basic
      {
        "id" => prescription.id,
        "token" => prescription.token,
        "signa" => prescription.signa,

        "customer-instructions" => prescription.customer_instructions,
        "pharmacist-instructions" => prescription.pharmacist_instructions,

        "tracking-number" => prescription.tracking_number,
        "tracking-url" => prescription.tracking_url,

        "cream-base" => prescription.cream_base,
        "fragrance" => prescription.fragrance,
        "volume-in-ml" => prescription.volume_in_ml,

        "is-copy" => prescription.is_copy,

        "created-at" => prescription.created_at,
        "fulfilled-at" => prescription.fulfilled_at,
        "updated-at" => prescription.updated_at,
      }
    end

    private def as_json_complete
      as_json_basic.merge(
        "pdf-url" => prescription_pdf_url(prescription_token: prescription.token),

        "customer-first-name" => prescription.visit.customer.first_name,
        "customer-last-name" => prescription.visit.customer.last_name,

        "should-show-to-pharmacists" => prescription.should_show_to_pharmacists?,

        "physician" => V2::PhysicianSerializer.new(prescription.physician, mode: mode).as_json,
        "formulation" => V2::FormulationSerializer.new(prescription.formulation, mode: mode).as_json,

        "prescription-ingredients" => prescription_ingredient_hashes,
      )
    end

    private def prescription_ingredient_hashes
      prescription.prescription_ingredients
                  .map { |pi| V2::PrescriptionIngredientSerializer.new(pi, mode: mode).as_json }
    end
  end
end
