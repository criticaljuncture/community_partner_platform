subdomain = ENV['SUBDOMAIN']

unless subdomain
  raise "ENV['SUBDOMAIN'] required" unless Rails.env.development? || Rails.env.test?

  subdomain = 'dev' if Rails.env.development?
  subdomain = 'test' if Rails.env.test?
end

Dir["#{Rails.root}/config/application_config/#{subdomain}/**/*.yml"].each do |file|
  Settings.add_source!(file)
end
Settings.reload!
