module V2
  class DiagnosisSerializer
    attr_reader :diagnosis, :mode

    # Serialization modes: [:complete]
    def initialize(diagnosis, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @diagnosis = diagnosis
      @mode = mode
    end

    def as_json
      return nil if diagnosis.nil?

      {
        "id" => diagnosis.id,
        "note" => diagnosis.note,

        "created-at" => diagnosis.created_at,

        "physician" => V2::PhysicianSerializer.new(diagnosis.physician, mode: mode).as_json,
        "diagnosis-conditions" => diagnosis_condition_hashes,
      }
    end

    private def diagnosis_condition_hashes
      diagnosis.diagnosis_conditions
               .map { |dc| V2::DiagnosisConditionSerializer.new(dc, mode: mode).as_json }
    end

  end
end

