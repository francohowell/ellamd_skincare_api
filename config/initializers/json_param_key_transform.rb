##
# This parameter transform applies to incoming parameters to change dashed keys to underscored.
#
# See `/config/initializers/active_model_serializer.rb` for the inverse transformation.
ActionDispatch::Request.parameter_parsers[:json] = ->(raw_post) do
  # Modified from action_dispatch/http/parameters.rb
  data = ActiveSupport::JSON.decode(raw_post)
  data = {_json: data} unless data.is_a?(Hash)

  # Transform camelCase and dashed param keys to snake_case:
  data.deep_transform_keys!(&:underscore)

  # Fix keys with numbers:
  data.deep_transform_keys! { |key| key.gsub(/([A-Za-z])(\d)/, "\\1_\\2") }
  data.deep_transform_keys! { |key| key.gsub(/(\d)([A-Za-z])/, "\\1_\\2") }
end
