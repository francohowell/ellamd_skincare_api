module V2
  class AnnotationSerializer
    attr_reader :annotation, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(annotation, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @annotation = annotation
      @mode = mode
    end

    def as_json
      return nil if annotation.nil?

      {
        "id" => annotation.id,

        "position-x" => annotation.position_x,
        "position-y" => annotation.position_y,
        "note" => annotation.note,

        "created-at" => annotation.created_at,
      }
    end
  end
end
