module V2
  class PhotoConditionSerializer
    attr_reader :photo_condition, :mode

    # Serialization modes: [::complete]
    def initialize(photo_condition, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(complete))

      @photo_condition = photo_condition
      @mode = mode
    end

    def as_json
      return nil if photo_condition.nil?

      {
        "id" => photo_condition.id,

        "note" => photo_condition.note,
        "canvas-data" => photo_condition.canvas_data,

        "created-at" => photo_condition.created_at,

        "condition" => V2::ConditionSerializer.new(photo_condition.condition, mode: mode).as_json,
      }
    end
  end
end

