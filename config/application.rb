require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CommunityPartnerPlatform
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += Dir[Rails.root.join('app', 'audits', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'decorators', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'forms', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'importers', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'inputs', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'policies', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'presenters', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('lib')]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
