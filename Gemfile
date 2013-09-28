source 'https://rubygems.org'

# Remove annoying messages from default webrick
gem 'webrick', '1.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

# Use mysql as the database for Active Record
gem 'mysql2'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem "bootstrap-sass", "~> 2.3.2.0"
gem "formtastic", git: 'git://github.com/justinfrench/formtastic.git', ref: "593ed1e43e8fbf35da589186720d35e7f444519f"
gem "formtastic-bootstrap", "~> 2.1.3"

gem "underscore-rails"

# aws email
gem "aws-ses", "~> 0.5.0"


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

gem 'active_model_serializers'

gem "d3_rails", "~> 3.2.4"

gem "devise", "~> 3.1.0"
gem "devise_invitable", 
    :github => "scambra/devise_invitable"
gem "cancan", "~> 1.6.10"

group :development, :test do
  gem "rspec-rails", "~> 2.14.0"
  gem "factory_girl_rails", "~> 4.2.1"
  gem "database_cleaner", "~> 1.1.1"

  gem "better_errors"
  gem "binding_of_caller"
  gem "zeus"

  # don't log asset loading as it's too noisy
  gem "quiet_assets"
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
