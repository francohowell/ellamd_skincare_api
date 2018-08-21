require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "sprockets/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EllaMD; end

##
# This is our main Rails application.
class EllaMD::Application < Rails::Application
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers; all .rb files in that
  # directory are automatically loaded.

  # Only loads a smaller set of middleware suitable for API only apps.
  # Middleware like session, flash, cookies can be added back manually.
  # Skip views, helpers and assets when generating a new resource.
  config.api_only = true

  # Autoload all of our application code.
  config.eager_load_paths += Dir[Rails.root.join("app", "modules")]
  config.eager_load_paths += Dir[Rails.root.join("app", "lib")]
  config.eager_load_paths += Dir[Rails.root.join('lib', '**/')]

  # Set the host from our configuration.
  Rails.application.routes.default_url_options[:host] = Figaro.env.host!

  # Let DelayedJob manage our ActiveJob queues.
  config.active_job.queue_adapter = :delayed_job

  # Configure Paperclip to connect to our S3 account.
  config.paperclip_defaults = {
    storage: :s3,
    hash_secret: Figaro.env.secret_token!,
    hash_data: ":class/:attachment/:id/:updated_at",
    s3_credentials: {
      bucket: Figaro.env.s3_bucket_name!,
      access_key_id: Figaro.env.s3_access_key_id!,
      secret_access_key: Figaro.env.s3_secret_access_key!,
      s3_region: Figaro.env.s3_region!,
    },
  }

  # Configure Stripe.
  Stripe.api_key = Figaro.env.stripe_secret_key!

  # Configure Phony.
  PhonyRails.default_country_code = "US"

  # Configure Twilio.
  Twilio.configure do |config|
    config.account_sid = Figaro.env.twilio_account_sid!
    config.auth_token = Figaro.env.twilio_auth_token!
  end
end
