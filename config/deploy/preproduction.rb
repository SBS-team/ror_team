server '192.168.137.1', :web, :app, :db, :primary => true

set :deploy_to, "/var/www/admintools.loc/rorteam.loc/preproduction"
 
set :rails_env, "preproduction"
set :user, "admintools"
 
set :unicorn_conf, "#{deploy_to}/current/config/unicorn_pre.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
 
set :shared_path, "#{deploy_to}/shared"

set :branch, 'dev'

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
run "cd #{release_path}; bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"    
#run "bundle exec unicorn #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end


