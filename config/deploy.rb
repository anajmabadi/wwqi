$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

require 'bundler/capistrano'
require 'rvm/capistrano'
require 'erb'

require File.join(File.dirname(__FILE__), 'initializers', 'security_credentials')

set :rvm_ruby_string, '1.9.2@wwqi'
set :rvm_type, :user


set :use_sudo, false
set :user, 'ubuntu'
ssh_options[:forward_agent] = true

set :application, 'wwqi'
set :deploy_to,   "/srv/app/#{application}"
set :repository, 'git@github.com:anajmabadi/wwqi.git'
set :scm, :git
set :deploy_via, :remote_cache
set :keep_releases, 3


# Multistage support without any dependencies
# See: https://github.com/capistrano/capistrano/wiki/2.x-Multiple-Stages-Without-Multistage-Extension
#task :production do
  server PRODUCTION_SERVER, :app, :web, :db, :primary => true
  set :tickle_command, "curl -Is localhost"
#end


namespace :deploy do
  
  task :set_branch do
    set :branch, Capistrano::CLI.ui.ask("Git treeish to deploy (e.g. master, rel-1.2.2): "){|q| q.default = 'master' }
  end

  task :enable_maintenance_page do
    run "(ln -sf #{deploy_to}/current/public/maintenance.html #{deploy_to}/current/public/system/maintenance.html) || true"
  end
  
  task :disable_maintenance_page do
    run "rm -f #{deploy_to}/public/system/maintenance.html"
  end
  
  # TODO: Replace start/stop with monit.
  task :start, :roles => :app do
    run "cd #{deploy_to}/current; bundle exec unicorn_rails -D -E production -c config/unicorn.rb"
    disable_maintenance_page
  end

  task :stop, :roles => :app do
    enable_maintenance_page
    run %^if [ -f "#{deploy_to}/shared/pids/unicorn.pid" ]; then (kill `cat #{deploy_to}/shared/pids/unicorn.pid`) || true ; fi^
  end

  task :shadow_puppet do
    run "sudo /var/lib/gems/1.8/bin/shadow_puppet #{current_release}/manifests/wwqi_manifest.rb"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    stop; start
  end
 
  task :tickle, :roles => :app do
    run tickle_command
  end

  task :bootstrap_app_dir do
    run 'if [ -e /mnt ] ; then sudo mkdir -p /mnt/app; sudo chown ubuntu:ubuntu -R /mnt/app; sudo rm /srv/app -rf; sudo ln -nsf /mnt/app /srv/app; else sudo mkdir -p /srv/app; sudo chown ubunut:ubunut -R /srv/app; fi'
  end

end

namespace :db do
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
production:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  pool: 5
  username: #{PRODUCTION_DATABASE_USERNAME}
  password: #{PRODUCTION_DATABASE_PASSWORD}
  host: #{PRODUCTION_DATABASE_HOSTNAME}
  database: #{application}_production
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



# deploy:setup callbacks
before 'deploy:setup', 'deploy:bootstrap_app_dir'
before "deploy:setup", :db, :security

# deploy callbacks
before 'deploy', 'deploy:set_branch'
before 'bundle:install', 'deploy:shadow_puppet'
after "deploy:update_code", "db:symlink", "security:symlink"
after 'deploy', 'deploy:tickle'
