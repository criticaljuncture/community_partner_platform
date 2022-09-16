require_relative 'boot'

require "rails"
# only load the frameworks we use
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CommunityPartnerPlatform
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #
    # App specific changes
    #

    config.time_zone = 'Pacific Time (US & Canada)'

    # modify locale files loaded to only include the overrides for the
    # configured subdomain
    config.i18n.load_path = Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')] -
      Dir[Rails.root.join('config', 'locales', 'overrides', '**', '*.{rb,yml}')] +
      Dir[Rails.root.join('config', 'locales', 'overrides', Settings.application.subdomain, '*.{rb,yml}')]
  end
end
