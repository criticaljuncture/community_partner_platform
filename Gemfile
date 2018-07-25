source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2'

# Use mysql as the database for Active Record
gem 'mysql2'

# production app server
gem 'passenger', '5.3.3'

# Memory based static tables
gem 'active_hash'

# json api
gem 'active_model_serializers' #0.8.1

# fast imports
gem 'activerecord-fast-import', '~> 0.2.1'
gem 'temping', '~> 3.2.0'

# makes small classes easier to cleanup and define without resorting to structs, etc.
gem 'attr_extras'

# AWS email
gem "aws-ses", "~> 0.5.0"

# fast application loading
gem 'bootsnap', require: false

# date picker component
gem 'bootstrap-datepicker-rails', '~> 1.6.4.1'

# Twitter bootstrap
gem 'bootstrap-sass', '~> 3.3.5.1'

# Check if point exists in kml boundary
gem 'border_patrol', git: 'https://github.com/square/border_patrol'

# css3 mixins, etc
gem "bourbon", "~> 4.2.3"

# permissions
gem "cancancan"

# Use CoffeeScript
gem 'coffee-rails'

# Settings via settings.yml, etc.
gem 'config'

# user signin and auth checks
gem "devise"
gem "devise_invitable"

# graphing
gem "d3_rails", "~> 3.3.7"

# decorator pattern
gem 'draper'

# define application_config schemas
gem 'dry-validation'

# memcached client
gem "dalli", "~> 2.6.4"

# forms
gem 'simple_form'

# Handlebars js templates
gem 'handlebars_assets'

# error reporting
gem 'honeybadger'

# Easy cookie access from JS
gem 'js_cookie_rails'

# named routes in javascript
gem 'js-routes'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# modals
gem 'jquery-modal-rails-assets'

# record versioning
gem 'paper_trail'

# auto linking user input (like organization url)
gem 'rails_autolink', '~> 1.1', '>= 1.1.6'

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


group :development, :test do
  # ascii table values - test multiple cases via tables for clarity
  gem 'atv'

  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "database_cleaner"

  gem "better_errors"
  gem "binding_of_caller"

  # replace rails console with pry
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'

  # live reloading of css & html via chrome browser extension
  gem 'guard', '~> 2.13.0'

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
