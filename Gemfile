source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7.1'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.20'

# production app server
gem 'passenger', '5.1.12'

# Memory based static tables
gem 'active_hash'

# json api
gem 'active_model_serializers' #0.8.1

# fast imports
gem 'activerecord-fast-import', '~> 0.2.1'
gem 'temping', '~> 3.2.0'

# AWS email
gem "aws-ses", "~> 0.5.0"

# Twitter bootstrap
gem 'bootstrap-sass', '~> 3.3.5.1'

# Check if point exists in kml boundary
gem 'border_patrol', git: 'https://github.com/square/border_patrol'

# css3 mixins, etc
gem "bourbon", "~> 4.2.3"

# permissions
gem "cancancan"

# Use CoffeeScript
gem 'coffee-rails', '~> 4.0.0'

# Settings via settings.yml, etc.
gem 'config', '~> 1.0.0'

# user signin and auth checks
gem "devise", "~> 3.5.2"
gem "devise_invitable", "~> 1.5.2 "
#gem "devise", "~> 3.1.2"
#gem "devise_invitable",
#    github: "scambra/devise_invitable",
#    ref: 'e555f07ffb1d7751e9f84b3283fc90e1820fb681'

# graphing
gem "d3_rails", "~> 3.3.7"

# decorator pattern
gem 'draper'

# define application_config schemas
gem 'dry-validation'

# env vars
gem 'dotenv', '= 0.11.1'
gem 'dotenv-rails', '= 0.11.1'
gem 'dotenv-deployment', '= 0.0.2'

# memcached client
gem "dalli", "~> 2.6.4"

# forms
gem 'formtastic', '~> 3.1.3'
gem 'formtastic-bootstrap', '~> 3.1.1'
gem 'simple_form', '~> 3.4.0'

# Handlebars js templates
gem 'handlebars_assets'

# error reporting
gem 'honeybadger'

# named routes in javascript
gem 'js-routes', '~> 1.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-cookie-rails'

# redis analytics
gem "minuteman", "~> 2.0.0"

# record versioning
gem 'paper_trail', '>= 3.0.0.rc1'

# redis
gem 'redis', '~> 3.3.2'
gem 'redis-namespace', '~> 1.5.2'

# threadsafe per-request global storage
gem 'request_store'

# prevent target blank fishing attack vector
gem 'safe_target_blank'

# Use SCSS for stylesheets
gem 'sass', '~> 3.4.16'
gem 'sass-rails', '~> 5.0.6'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# JS helper functions
gem "underscore-rails"

# multi-step wizard like controllers
gem "wicked"

# date picker component
gem 'bootstrap-datepicker-rails', '~> 1.6.4.1'

# makes small classes easier to cleanup and define without resorting to structs, etc.
gem 'attr_extras'

# modals
gem 'jquery-modal-rails',
    git: 'https://github.com/peregrinator/jquery-modal-rails',
    ref: '97bc84d7723d324876971f45f255e066fbb6ad49'

# auto linking user input (like organization url)
gem 'rails_autolink', '~> 1.1', '>= 1.1.6'


group :deployment do
  gem 'capistrano', '~> 2.15.5'
  gem 'thunder_punch', '~> 0.1.6'
end

group :development, :test do
  # ascii table values - test multiple cases via tables for clarity
  gem 'atv'

  gem 'spring'
  gem 'spring-commands-rspec'

  gem "rspec-rails", "~> 3.5.2"
  gem "factory_girl_rails", "~> 4.8.0"
  gem "database_cleaner", "~> 1.5.3"

  gem "better_errors"
  gem "binding_of_caller"
  #gem "zeus"

  # replace rails console with pry
  gem 'pry', '~> 0.10.0'
  gem 'pry-rails'
  gem 'pry-remote'

  # don't log asset loading as it's too noisy
  gem "quiet_assets"

  # live reloading of css & html via chrome browser extension
  gem 'guard', '~> 2.13.0'

  # console on errors or using <%= console %>
  gem 'web-console', '~> 2.0'

  gem 'rack-mini-profiler'

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
