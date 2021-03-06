require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if RUBY_PLATFORM == 'java'
  begin
      require 'java'
      java_import 'java.lang.ClassNotFoundException'
      security_class = java.lang.Class.for_name('javax.crypto.JceSecurity')
      restricted_field = security_class.get_declared_field('isRestricted')
      restricted_field.accessible = true
      restricted_field.set nil, false
  rescue ClassNotFoundException => e
    # Handle Mac Java, etc not having this configuration setting
    $stderr.print "Java told me: #{e}n"
  end
end


module TicketToRide
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

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec,
        :fixtures => true, # generates a fixture for each model using Factory Girl
        :view_specs => false, # skips generating view specs
        :helper_specs => false, # skips generting specs for the helper files generated with each controller
        :routing_specs => false, # omits a spec file for routes.rb
        :controller_specs => true, 
        :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories" # tells Rails to generate factories instead of fixtures
    end

  end
end
