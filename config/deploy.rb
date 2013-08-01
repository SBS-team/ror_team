require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano' # Для работы bundler. При изменении гемов bundler автоматически обновит все гемы на сервере, чтобы они в точности соответствовали гемам разработчика. 
require 'capistrano/ext/multistage'

set :rvm_path,        '/var/www/admintools.loc/.rvm'
set :rvm_bin_path,    '/var/www/admintools.loc/.rvm/bin'
set :using_rvm,       true
set :rvm_ruby_string, "ruby-2.0.0-p247@rorteam_dev"

set :application, "rorteam"
set :user, "admintools"
set :use_sudo, false
#set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
#set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

#set :rvm_ruby_string, 'ree' # Это указание на то, какой Ruby интерпретатор мы будем использовать.
#set :rvm_ruby_string, 'ruby-2.0.0-p247' # Это указание на то, какой Ruby интерпретатор мы будем использовать.

set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git. 
set :repository,  "git@github.com:is-valid/ror_team.git"# Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить $
#set :branch, "master" # Ветка из которой будем тянуть код для деплоя.
set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.

role :web, '192.168.137.1'
role :app, '192.168.137.1'
role :db,  '192.168.137.1', :primary => true

set(:deploy_to) { "/var/www/admintools.loc/rorteam.loc/#{stage}" }
set :stages,          %w(preproduction production)
set :default_stage,   "preproduction"
set :keep_releases, 3

set :migrate_target, :latest

after "deploy:finalize_update", "deploy:migrate"
before 'deploy:migrate', 'config:symlink'
#after "deploy:restart" #, "resque:scheduler:restart"


before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby' # интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.

namespace :config do
  desc 'Symlink configuration files.'
  task :symlink do
#    %w(database.yml preproduction.yml).each do |file|
#      run "ln -nfs #{shared_path}/#{file} #{release_path}/config/#{file}"
#      run "ln -nfs #{shared_path}/#{file} #{release_path}/config/environments/#{file}"    
#end
    run "ln -nfs #{shared_path}/preproduction.yml #{release_path}/config/environments/preproduction.yml"    
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/development.yml #{release_path}/config/environments/development.yml"
    run "ln -nfs #{shared_path}/unicorn_pre.rb #{release_path}/config/unicorn_pre.rb"

  end
end

#after 'deploy:update_code', :roles => :app do
  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml. Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда. При каждом деплое создаются ссылки на них$
#  run "rm -f #{current_release}/config/database.yml"
#  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
#end

# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
# В случае с Rails 3 приложениями стоит заменять bundle exec unicorn_rails на bundle exec unicorn
#namespace :deploy do
#  task :restart do
#    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn #{unicorn_conf} -E #{rails_env} -D; fi"
#  end
#  task :start do
#    run "bundle exec unicorn #{unicorn_conf} -E #{rails_env} -D"
#  end
#  task :stop do
#    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
#  end
#end

#before "rails:console", "bundle:install"
namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    exec "ssh -l #{user} '192.168.137.1' -t 'cd #{current_path} && bundle install && bundle exec rails c #{stage}'"
  end
end

desc "tail production log files"
task :tail_logs, :roles => :app do
  trap("INT") { puts 'Interupted'; exit 0; }
  run "tail -f #{shared_path}/log/#{stage}.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

after "deploy", "deploy:cleanup"
