##
# All of our serializers inherit from this ApplicationSerializer.
#
# We extensively use ActiveModelSerializers to handle serialization and display of our application's
# responses to requests.
class ApplicationSerializer < ActiveModel::Serializer
  ##
  # We can use this `always_include` method within a serializer to ensure that an associated
  # object is always included in the serialized response, even if the parent object is already
  # being included as an association.
  #
  # For example, if we `always_include` a Prescription's PrescriptionIngredients, then those
  # PrescriptionIngredients will appear in the response when a Customer is requested (assuming the
  # Customer serializer includes the Customer's Prescriptions).
  def self.always_include(name, options = {})
    options[:key] ||= name
    method_name = name.to_s + "_serialized"

    define_method method_name do
      data = respond_to?(name) ? send(name) : object.send(name)

      if data
        options = instance_options.dup
        options.delete(:serializer)
        options.delete(:each_serializer)

        # Use Attributes adapter here instead of JSON as we dont want a root object:
        options[:adapter] = ActiveModelSerializers::Adapter::Attributes

        resource = ActiveModelSerializers::SerializableResource.new(data, options)
        resource.serializable_hash
      end
    end

    attribute(method_name, options)
  end

  # It would be nicer to have .attribute correctly serialize dates,
  #   but it seems to be tricky and I don't want to spend too much time on it
  def self.date(name)
    attribute(name) { object.send(name)&.strftime("%Y-%m-%d") }
  end
end
