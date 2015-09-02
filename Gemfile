source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.3'

# Use mysql as the database for Active Record
gem 'mysql2'

# json api
gem 'active_model_serializers'

# AWS email
gem "aws-ses", "~> 0.5.0"

# Twitter bootstrap
gem 'bootstrap-sass', '~> 3.3.5.1'

# css3 mixins, etc
gem "bourbon", "~> 4.2.3"

# permissions
gem "cancan", "~> 1.6.10"

# Use CoffeeScript
gem 'coffee-rails', '~> 4.0.0'

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

# env vars
gem 'dotenv-rails'

# memcached client
gem "dalli", "~> 2.6.4"

# forms
gem 'formtastic', '~> 3.1.3'
gem 'formtastic-bootstrap', '~> 3.1.1'
gem 'simple_form', '~> 3.1.0'

# Handlebars js templates
gem 'handlebars_assets'

# error reporting
gem 'honeybadger'

# named routes in javascript
gem 'js-routes', '~> 1.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# redis analytics
gem "minuteman-rails",
  git: 'git@github.com:elcuervo/minuteman-rails.git',
  ref: '473197950a5072fa60bda39f4736098958d7b9ed'
gem "minuteman", "~> 1.0.3"

# record versioning
gem 'paper_trail', '>= 3.0.0.rc1'

# redis
gem 'redis', '~> 3.0.7'
gem 'redis-namespace', '~> 1.4.1'

# Use SCSS for stylesheets
gem 'sass', '~> 3.4.16'
gem 'sass-rails', '~> 5.0.3'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# JS helper functions
gem "underscore-rails"

# multi-step wizard like controllers
gem "wicked"



# modals
gem 'jquery-modal-rails',
    github: 'peregrinator/jquery-modal-rails',
    ref: '97bc84d7723d324876971f45f255e066fbb6ad49'

# libcurl binding
gem 'curb', '~> 0.8.5'

group :deployment do
  gem 'capistrano', '~> 2.15.5'
  gem 'thunder_punch', '~> 0.1.2'
end

group :development, :test do
  gem "rspec-rails", "~> 2.14.0"
  gem "factory_girl_rails", "~> 4.2.1"
  gem "database_cleaner", "~> 1.1.1"

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
  gem 'guard'
  gem 'guard-livereload'

  # console on errors or using <%= console %>
  gem 'web-console', '~> 2.0'

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
