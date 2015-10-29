#############################################################
# Set Basics
#############################################################
set :application, "community_partner_platform"
set :user, "deploy"
set :current_path, "/var/www/apps/#{application}"

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]


#############################################################
# General Settings
#############################################################

set :deploy_to,  "/var/www/apps/#{application}"
set :rake, "bundle exec rake"

#############################################################
# Set Up for Production Environment
#############################################################

task :production do
  set :rails_env,  "production"
  set :branch, "master"

  set :gateway, 'www.communitypartnerplatform.org'

  role :app,    "cpp-app-server-1.ec2.internal"
  role :db,     "cpp-database-ec2.internal", {:primary => true}
end


#############################################################
# Set Up for Staging Environment
#############################################################

task :staging do
  set :rails_env,  "staging"
  set :branch, "master"

  set :current_path, "/var/www/apps/staging_#{application}"
  set :deploy_to,  "/var/www/apps/staging_#{application}"

  set :gateway, 'www.communitypartnerplatform.org'

  role :app,    "cpp-app-server-1.ec2.internal"
  role :db,     "cpp-database-ec2.internal", {:primary => true}
end



#############################################################
# SCM Settings
#############################################################
set :scm,              :git
set :github_user_repo, 'criticaljuncture'
set :github_project_repo, 'community_partner_platform'
set :deploy_via,       :remote_cache
set :repository, "git@github.com:#{github_user_repo}/#{github_project_repo}.git"
set :github_username, 'criticaljuncture'


#############################################################
# Bundler
#############################################################
# this should list all groups in your Gemfile (except default)
set :gem_file_groups, [:deployment, :development, :test]


#############################################################
# Honeybadger
#############################################################

set :honeybadger_user, `git config --global github.user`.chomp


#############################################################
# Recipe role setup
#############################################################

set :deploy_roles, [:app]
set :bundler_roles, [:app]
set :db_migration_roles, [:db]
set :asset_roles, [:app]


#############################################################
# Run Order
#############################################################

# Do not change below unless you know what you are doing!
after "deploy:update_code",           "bundler:bundle"
after "bundler:bundle",               "deploy:migrate"
after "deploy:migrate",               "assets:precompile"
after "assets:precompile",            "passenger:restart"
after "passenger:restart",            "honeybadger_cli:dotenv:notify_deploy"


#############################################################
#                                                           #
#                                                           #
#                         Recipes                           #
#                                                           #
#                                                           #
#############################################################

# Add any custom recipes here...


# deploy recipes - these should be required last
require 'thunder_punch'
require 'thunder_punch/recipes/assets'
require 'thunder_punch/recipes/passenger'
require 'thunder_punch/recipes/honeybadger'
