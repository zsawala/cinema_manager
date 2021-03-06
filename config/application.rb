require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CinemaManager
  class Application < Rails::Application
    require 'dotenv'
    Dotenv.load('.env')
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.eager_load_paths.concat(
      [
        "#{config.root}/lib",
        "#{config.root}/lib/exceptions"
      ]
    )

    config.api_only = true

    config.jwt = ActiveSupport::OrderedOptions.new
    config.jwt.hmac_secret = ENV['JWT_HMAC_SECRET']

    config.open_movie = ActiveSupport::OrderedOptions.new
    config.open_movie.api_key = ENV['OPEN_MOVIE_API_KEY']
    config.open_movie.url = ENV['OPEN_MOVIE_URL']
  end
end
