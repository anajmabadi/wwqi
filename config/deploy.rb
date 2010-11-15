require 'erb'

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

before "deploy:setup", :db
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
    base: &base
      adapter: mysql
      encoding: utf8
      reconnect: false
      pool: 5
      username: qajar
      password: Q@jar!
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