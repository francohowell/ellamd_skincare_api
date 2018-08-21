module V2
  class VisitSerializer
    attr_reader :visit, :mode

    # Serialization modes: [:basic, complete]
    def initialize(visit, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @visit = visit
      @mode  = mode
    end

    def as_json
      return nil if visit.nil?

      case mode
      when :basic    then as_json_basic
      when :complete then as_json_complete
      end
    end

    private def as_json_basic
      {
        "id" => visit.id,
        "payment-status" => visit.payment_status,

        "created-at" => visit.created_at,
        "updated-at" => visit.updated_at,

        "prescription" => V2::PrescriptionSerializer.new(visit.prescription, mode: mode).as_json,
      }
    end

    private def as_json_complete
      as_json_basic.merge(
        "photos" => photo_hashes,
        "diagnosis" => V2::DiagnosisSerializer.new(visit.diagnosis, mode: mode).as_json,
        "regimen" => V2::RegimenSerializer.new(visit.regimen, mode: mode).as_json,
      )
    end

    private def photo_hashes
      visit.photos
           .map { |photo| V2::PhotoSerializer.new(photo, mode: mode).as_json }
    end
  end
end
