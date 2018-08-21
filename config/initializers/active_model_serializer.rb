# Transform the underscored keys provided by Rails to dashed versions for transport.
# See `/config/initializers/json_param_key_transform.rb` for the inverse transformation.
ActiveModelSerializers.config.key_transform = :dash

# Include a single level of associations by default.
ActiveModelSerializers.config.default_includes = "*"

# Use the JSON AMS adapter.
ActiveModelSerializers.config.adapter = :json

# Silence the logging; it prints a lot:
ActiveModelSerializers.logger =
  ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new("/dev/null"))
