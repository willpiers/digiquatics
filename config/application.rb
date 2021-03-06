require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'
require 'csv'
require 'mixpanel-ruby'

require File.expand_path('../mixpanel_stub', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

unless ENV['MIXPANEL_TOKEN']
  puts "WARN: missing env variable \"MIXPANEL_TOKEN\"\n" \
    'Put `export MIXPANEL_TOKEN=<dev token>` in your `~/.zshrc` file'
end

if Rails.env.production?
  Tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN'] || '1')
else
  Tracker = MixpanelStub
end

module DigiQuatics
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('app', '{**/}')]

    # system("rubocop -D #{Rails.root}") if Rails.env.development?

    config.generators do |g|
      g.stylesheets false
      g.test_framework false
    end

    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    #config.time_zone = 'Mountain Time (US & Canada)'

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path +=
    #   Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    SESSIONS = proc { |controller| user_signed_in? ? 'application' : 'devise' }

    config.to_prepare do
      Devise::SessionsController.layout SESSIONS
      Devise::RegistrationsController.layout SESSIONS
      Devise::ConfirmationsController.layout SESSIONS
      Devise::UnlocksController.layout SESSIONS
      Devise::PasswordsController.layout SESSIONS
    end

    I18n.enforce_available_locales = true
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    # exclude '{' => '}' to avoid conflict with AngularJS
    Slim::Engine.set_default_options attr_delims: { '(' => ')', '[' => ']' }
  end
end
