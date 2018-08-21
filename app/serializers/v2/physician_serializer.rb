module V2
  class PhysicianSerializer
    attr_reader :physician, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(physician, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @physician = physician
      @mode = mode
    end

    def as_json
      return nil if physician.nil?

      {
        "id" => physician.id,
        "first-name" => physician.first_name,
        "last-name" => physician.last_name,
        "email" => physician.email,

        "signature-image-url" => physician.signature_image.url,
      }
    end
  end
end
