module V2
  class PhotoSerializer
    attr_reader :photo, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(photo, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @photo = photo
      @mode = mode
    end

    def as_json
      return nil if photo.nil?

      case mode
      when :basic    then as_json_basic
      when :complete then as_json_complete
      end
    end

    private def as_json_basic
      {
        "id" => photo.id,
        "visit-id" => photo.visit_id,

        "thumbnail-url" => photo_image.url(:thumbnail),
        "small-url" => photo_image.url(:small),
        "medium-url" => photo_image.url(:medium),
        "large-url" => photo_image.url(:large),

        "created-at" => photo.created_at,
      }
    end

    private def as_json_complete
      as_json_basic.merge(
        "annotations" => annotation_hashes,
        "photo-conditions" => photo_condition_hashes,
      )
    end

    private def photo_image
      @photo_image ||= photo.image
    end

    private def annotation_hashes
      photo.annotations
           .map { |annotation| V2::AnnotationSerializer.new(annotation, mode: mode).as_json }
    end

    private def photo_condition_hashes
      photo.photo_conditions
           .map { |pc| V2::PhotoConditionSerializer.new(pc, mode: mode).as_json }
    end
  end
end
