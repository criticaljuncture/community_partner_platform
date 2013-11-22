OusdCommunityPartners::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  # config.action_controller.perform_caching = false
  #
  config.action_controller.perform_caching = true
  begin
    # check if memcached is running; if it is, use that instead of the default memory cache
    Timeout.timeout(0.5) { TCPSocket.open("localhost", 11211) { } }
    config.cache_store = :dalli_store, %w(localhost:11211), { :namespace => ENV['APP_SUBDOMAIN'], :compress => true }
    $stderr.puts "Using memcached on localhost:11211"
  rescue StandardError
    config.cache_store = nil
    $stderr.puts "memcached not running, caching to memory"
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.sass.debug_info = true
  config.sass.line_comments = false

  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.default_url_options = { :host => 'localhost:15000' }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"

  config.action_controller.action_on_unpermitted_parameters = :raise
end
