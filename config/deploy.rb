require 'capistrano/ext/multistage'
#set :stages, %w(production beta)

#set :default_stage, 'beta'
#set :default_env, 'beta'

set :application, "app_name"

role :app, '3.xserve.pl'
role :web, '3.xserve.pl'
role :db,  '3.xserve.pl', :primary => true

set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git
set :repository, "git@3.xserve.pl:#{application}.git"

# set :branch, "production"
# set :deploy_via, :remote_cache

# set :user, 'oki'
set :user, 'git'
set :ssh_options, { :paranoid => false }

set :use_sudo, false

set :keep_releases, 5

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
