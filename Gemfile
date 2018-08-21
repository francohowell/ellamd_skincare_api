source "https://rubygems.org"
# ruby "2.5.1"

# `rails` is the framework on which this API is built.
gem "rails", "5.2.0"

# `puma` is our application server.
gem "puma", "3.11.4"

# `pg` is our Postgres database adapter.
gem "pg", "1.0.0"

# `active_record_upsert` provides ActiveRecord interface to PostgreSQL upsert statement
gem "active_record_upsert", "0.9.1"

# `rack-cors` provides the middleware to manage our CORS policy.
gem "rack-cors", "1.0.2"

# `devise` provides authentication functionality, and
# `devise_token_auth` extends that functionality with bearer-token authentication schemes.
gem "devise", "4.4.3"
gem "devise_token_auth", "0.1.43"

# `figaro` provides configuration via environment variables.
gem "figaro", "1.1.1"

# Boot large Ruby/Rails apps faster
gem 'bootsnap', "1.3.0", require: false

# `active_model_serializers` defines the serializers that render all of the API's responses.
gem "active_model_serializers", "0.10.7"

gem "actionpack-action_caching", "1.2.0"

# `paperclip` manages attachments, e.g. for Customer's Photos.
# We use `aws-sdk` to plug Paperclip into our S3 account.
gem "paperclip", "6.0.0"
gem "aws-sdk-s3", "1.13.0"

# `wicked_pdf` offers server-side PDF generation. We use `wkhtmltopdf-binary` to pull in a
# precompiled version of `wkhtmltopdf` to convert HTML files to PDFs.
gem "wicked_pdf", "1.1.0"
gem "wkhtmltopdf-binary", "0.12.3.1"

# `access-granted` manages our authorization policies.
gem "access-granted", "1.3.1"

# `audited` keeps track of changes to our models.
gem "audited", "4.7.1"

# `delayed_job_active_record` manages our asynchronous jobs and queues.
gem "delayed_job_active_record", "4.1.3"

# `phony_rails` provides phone number normalization.
gem "phony_rails", "0.14.7"

# `sendgrid-ruby` is a wrapper around SendGrid's Web API.
gem "sendgrid-ruby", "5.2.0"

# `sentry-raven` is Sentry.io's wrapper to allow us to report and track exceptions.
gem "sentry-raven", "2.7.3"

# `stripe` is Stripe's wrapper to manage payments.
gem "stripe", "3.15.0"

# Stripe webhook integration for Rails applications.
gem "stripe_event", "2.1.1"

# `twilio-ruby` is Twilio's wrapper to manage telephone communications (e.g. sending texts).
gem "twilio-ruby", "5.10.2"

# `analytics-ruby` is Segment's wrapper to manage analytics.
gem "analytics-ruby", "2.2.5", require: "segment/analytics"

# `koala` is a wrapper for the Facebook Graph API.
gem "koala", "3.0.0"

# `tracking_number` allows to validate and recognize a carrier from a tracking number
gem "tracking_number", "1.0.3"

# `kaminari` allows paginating Active Record resources
gem "kaminari", "1.1.1"

# Easy-to-use HTTP client used for scraping third-party resources
gem "http", "3.3.0"

# Ruby bindings to Selenium - a browser automation framework and ecosystem
gem "selenium-webdriver", "3.12.0"

# `addressable` allows parsing URIs
gem "addressable", "2.5.2"

# AlgoliaSearch integration to ActiveRecord
gem "algoliasearch-rails", "1.20.4"

# `Skylight` is a smart profiler for Ruby and Rails applications.
gem "skylight", "2.0.1"

# These are mostly for testing but it's handy to have them available in rails console too
group :development, :test do
  gem "byebug", ">= 10.0.2"

  gem "rspec-rails", ">= 3.7.2"
  gem "rspec_junit_formatter", ">= 0.4.0"

  gem "factory_bot_rails", ">= 4.10.0"
end

# We only load the development group of gems in development, so any gem that is not needed on
# production belongs here.
group :development do
  # `pry` is a replacement for the default IRB-based console; the other gems here make the pry
  # experience even better.
  gem "pry-rails", ">= 0.3.6"
  gem "awesome_print", ">= 1.8.0"
  gem "table_print", ">= 1.5.6"

  # `spring` allows multiple processes to use the same Rails environment, speeding up boot times of
  # consoles, etc.
  gem "listen", ">= 3.1.5"
  gem "spring", ">= 2.0.2"
  gem "spring-watcher-listen", ">= 2.0.1"
end

group :test do
  # Mock HTTP requests
  gem "webmock", ">= 3.4.1"

  # Record HTTP interactions and replay them
  gem "vcr", ">= 4.0.0"

  # Mock time and date
  gem "timecop", ">= 0.9.1"
end

# Gems from this group are not needed by the application. They exist here to be run on the command line
group :dev_tools do
  # Annotate models and other files based on the database schema
gem "annotate", ">= 2.7.3"

  # Ruby linter
  gem "rubocop", ">= 0.56.0"

  # Code coverage analysis tool
  gem 'simplecov', '>= 0.16.1', require: false

  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'brakeman', '>= 4.3.0'

  # Patch-level verification for Bundler
  gem 'bundler-audit', '>= 0.6.0'

  # A Ruby code quality reporter
  gem 'rubycritic', '>= 3.4.0', require: false

  # Static analysis tool for checking your Ruby code for Sandi Metz' four rules.
  gem 'sandi_meter', '>= 1.2.0'
end
