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

set :scm, :subversion # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "https://historicus.springloops.com/source/qajar/trunk"
set :svn_username, "cforcey"
set :svn_password, "kailiv14"
set :checkout, "export"

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