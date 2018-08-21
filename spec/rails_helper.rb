require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"

# Requires supporting ruby files with custom matchers and macros, etc,
Dir[Rails.root.join("spec/support/helpers/*")].each { |f| require f }
Dir[Rails.root.join("spec/support/initializers/*")].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all
  config.use_transactional_fixtures = true
  config.render_views

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Helpers::Controller,             type: :controller
  config.include Helpers::Stripe
  config.include Helpers::Serializer

  config.before :each, type: :controller do |example|
    @request.env["devise.mapping"] = Devise.mappings[:identity]
  end

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
