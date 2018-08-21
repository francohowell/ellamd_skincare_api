module V2
  class ConditionSerializer
    attr_reader :condition, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(condition, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @condition = condition
      @mode = mode
    end

    def as_json
      return nil if condition.nil?

      {
        "id" => condition.id,
        "name" => condition.name,
        "description" => condition.description,
      }
    end
  end
end

