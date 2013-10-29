require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module CarpoolServer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    # For quiet assets
    config.quiet_assets = true


    # For FactoryGirl and RSpec
    config.generators do |g|
      g.test_framework :rspec,
      fixtures: true,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: true,
      request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end


    # CORS Middleware to configure for AJAX
    config.middleware.use Rack::Cors do
      allow do
        origins '*' #'localhost:3000', '127.0.0.1:3000', /http:\/\/192\.168\.0\.\d{1,3}(:\d+)?/
        # regular expressions can be used here

        # resource '/file/list_all/', :headers => 'x-domain-token'
        # resource '/file/at/*',
        resource '/api/v1/*',
        :methods => [:get, :post, :put, :delete, :options],
        :headers => :any, #'x-domain-token',
        # :expose  => ['Some-Custom-Response-Header'],
        :max_age => 600
        # headers to expose
      end

      # allow do
      #   origins '*'
      #   resource '/public/*', :headers => :any, :methods => :get
      # end
    end

  end
end