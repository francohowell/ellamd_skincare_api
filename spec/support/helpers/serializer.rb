module Helpers
  module Serializer
    def serialize(active_model)
      serialization = ActiveModelSerializers::SerializableResource.new(active_model)
      serialized_hash = serialization.to_json

      JSON.parse(serialized_hash).first[1]
    end
  end
end
