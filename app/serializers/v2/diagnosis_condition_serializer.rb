module V2
  class DiagnosisConditionSerializer
    attr_reader :diagnosis_condition, :mode

    # Serialization modes: [:complete]
    def initialize(diagnosis_condition, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @diagnosis_condition = diagnosis_condition
      @mode = mode
    end

    def as_json
      return nil if diagnosis_condition.nil?

      {
        "id" => diagnosis_condition.id,
        "description" => diagnosis_condition.description,
        "condition" => V2::ConditionSerializer.new(diagnosis_condition.condition, mode: mode).as_json,
      }
    end
  end
end

