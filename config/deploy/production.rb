server '192.168.137.75', :web, :app, :db, primary: true

set :deploy_to, '/home/admin/production/rorteam'
 
set :rails_env, 'production'
set :user, 'admintools'
 
set :unicorn_conf, "#{deploy_to}/current/config/unicorn_staging.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
 
set :shared_path, "#{deploy_to}/shared"

set :branch, 'master'

set :user, 'admin'
