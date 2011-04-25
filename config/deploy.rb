require 'erb'

# change this directory to the location of your security files
require "/Users/historicus/Code/qajar_women/config/initializers/security_credentials.rb"

#############################################################
#	Application
#############################################################

set :application, "qajar"
set :domain,      "qajarwomen.org"
set :deploy_to, "/var/www/vhosts/qajarwomen.org/httpdocs"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true
set :user, "cforcey"

#############################################################
#	Subversion
#############################################################

set :scm, :git # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "git://github.com/cforcey/qajar_women.git"
set :branch, "master"
set :deploy_via, :remote_cache

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run


namespace :deploy do

 task :start, :roles => :app do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end

  task :stop do
  # Do nothing.
 end

 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end

end

before "deploy:setup", :db, :security
after "deploy:update_code", "db:symlink", "security:symlink"

namespace :db do
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
    base: &base
      adapter: mysql
      encoding: utf8
      reconnect: false
      pool: 5
      username: #{PRODUCTION_DATABASE_USERNAME}
      password: #{PRODUCTION_DATABASE_PASSWORD
      host: localhost

    development:
      database: #{application}_development
      <<: *base

    test:
      database: #{application}_test
      <<: *base

    production:
      database: #{application}_production
      <<: *base
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config.result, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :security do
  desc "Create secure configurlation file in shared path"
  task :default do
    security_config = ERB.new <<-EOF
      # additional security tokens not to be checked into the open source repository, used by application_controller.rb and deploy.rb (Capistrano)
      ADMIN_USERNAME = '#{ADMIN_USERNAME}'
      ADMIN_PASSWORD = '#{ADMIN_PASSWORD}'
      PRODUCTION_DATABASE_USERNAME = '#{PRODUCTION_DATABASE_USERNAME}'
      PRODUCTION_DATABASE_PASSWORD = '#{PRODUCTION_DATABASE_PASSWORD}'
    EOF

    run "mkdir -p #{shared_path}/security"  
    put security_config.result, "#{shared_path}/security/security_credentials.rb"
    
    secret_token = ERB.new <<-EOF
      # Be sure to restart your server when you modify this file.
      
      # Your secret key for verifying the integrity of signed cookies.
      # If you change this key, all old signed cookies will become invalid!
      # Make sure the secret is at least 30 characters and all random,
      # no regular words or you'll be exposed to dictionary attacks.
      Qajar::Application.config.secret_token = '#{SECRET_TOKEN}'
    EOF

    put secret_token.result, "#{shared_path}/security/secret_token.rb"
  end

  desc "Make symlink for security rb"
  task :symlink do
    run "ln -nfs #{shared_path}/security/security_credentials.rb #{release_path}/config/initializers/security_credentials.rb"
    run "ln -nfs #{shared_path}/security/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
end