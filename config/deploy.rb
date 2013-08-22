require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano' # Для работы bundler. При изменении гемов bundler автоматически обновит все гемы на сервере, чтобы они в точности соответствовали гемам разработчика.
require 'capistrano/ext/multistage'

set :using_rvm,       true

set :application, 'rorteam'

set :use_sudo, false
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ['publickey']


set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git. 
set :repository,  'git@github.com:SBS-team/ror_team.git' # Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить $

set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.

set :stages,          %w(preproduction production)
set :default_stage,   'preproduction'
set :keep_releases, 3

set :migrate_target, :latest

set (:rvm_ruby_string){"ruby-2.0.0-p247@rorteam_#{stage}"}

after 'deploy:finalize_update', 'deploy:migrate'
before 'deploy:migrate', 'config:symlink'

before 'deploy:setup', 'rvm:install_ruby' # интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.
after 'deploy:setup', 'config:setup_folders'


namespace :config do
  desc 'Symlink configuration files.'
  task :symlink do
    run "ln -nfs #{shared_path}/#{stage}.yml #{release_path}/config/environments/preproduction.yml"
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/development.yml #{release_path}/config/environments/development.yml"
    run "ln -nfs #{shared_path}/unicorn_pre.rb #{release_path}/config/unicorn_pre.rb"
  end

  task :setup_folders do
    run "touch -m #{shared_path}/#{stage}.yml"
    run "touch -m #{shared_path}/database.yml"
    run "mkdir -p #{shared_path}/uploads"
    run "touch -m #{shared_path}/development.yml"
    run "touch -m #{shared_path}/unicorn_pre.rb"
  end
end

#before "rails:console", "bundle:install"
namespace :rails do
  desc 'Open the rails console on one of the remote servers'
  task :console, roles: :app do
    exec "ssh -l #{user} '192.168.137.75' -t 'cd #{current_path} && bundle install && bundle exec rails c #{stage}'"
  end
end

desc 'tail production log files'
task :tail_logs, roles: :app do
  trap('INT') { puts 'Interupted'; exit 0; }
  run "tail -f #{shared_path}/log/#{stage}.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

after 'deploy', 'deploy:cleanup'
