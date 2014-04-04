source 'https://rubygems.org'

# Remove annoying messages from default webrick
gem 'webrick', '1.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.4'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass', '~> 3.2.15'
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem "bootstrap-sass", "~> 2.3.2.0"
gem "formtastic", git: 'git://github.com/justinfrench/formtastic.git', ref: "cd6cb88f28ea7444267802ced8e5ec0f5cfd0f90"
gem "formtastic-bootstrap", "~> 2.1.3"

# css3 mixins
gem "bourbon", "~> 3.1.8"

gem "underscore-rails"

# aws email
gem "aws-ses", "~> 0.5.0"

# record versioning
gem 'paper_trail', '>= 3.0.0.rc1'

# ember
gem 'ember-rails'
gem 'ember-source', '1.4.0'
#gem "handlebars-source", "~> 1.1.1"

# redis
gem 'redis', '~> 3.0.7'
gem 'redis-namespace', '~> 1.4.1'

# redis analytics
gem "minuteman-rails",
  git: 'git@github.com:elcuervo/minuteman-rails.git',
  ref: '473197950a5072fa60bda39f4736098958d7b9ed'
gem "minuteman", "~> 1.0.3"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# json api
gem 'active_model_serializers'

# graphing
gem "d3_rails", "~> 3.3.7"

# user signin and auth checks
gem "devise", "~> 3.2.4"
gem "devise_invitable",
    :github => "scambra/devise_invitable"
gem "cancan", "~> 1.6.10"

# error reporting
gem 'honeybadger'
gem 'dotenv-rails'

# memcached client
gem "dalli", "~> 2.6.4"

# modals
gem 'jquery-modal-rails',
    github: 'peregrinator/jquery-modal-rails',
    ref: '97bc84d7723d324876971f45f255e066fbb6ad49'

group :development, :test do
  gem "rspec-rails", "~> 2.14.0"
  gem "factory_girl_rails", "~> 4.2.1"
  gem "database_cleaner", "~> 1.1.1"

  gem "better_errors"
  gem "binding_of_caller"
  #gem "zeus"

  # replace rails console with pry
  gem "pry", "~> 0.9.12.2"
  gem 'pry-rails'

  # don't log asset loading as it's too noisy
  gem "quiet_assets"

  # live reloading of css & html via chrome browser extension
  gem 'guard'
  gem 'guard-livereload'

  # chrome inspector support
  #gem 'sass-rails-source-maps'

  # application performance insights
  #gem "peek", "~> 0.1.7"
  #gem 'peek-git'
  #gem 'peek-mysql2'
  #gem 'peek-gc'
  #gem 'peek-performance_bar'
  #gem 'peek-rblineprof'
  #gem 'peek-dalli'
  #gem 'rack-mini-profiler'

  # Deployment
  #gem 'capistrano', "~> 2.15.5"
  #gem 'thunder_punch', require: false
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
