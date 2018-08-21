##
# Configure our Sentry.io integration.
Raven.configure do |config|
  config.dsn = Figaro.env.sentry_config_url!
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
