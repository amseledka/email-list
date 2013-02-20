require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'capistrano-helpers/bundler'
require 'rvm/capistrano'

# RVM
set :using_rvm,        true
set :rvm_ruby_string,  "1.9.3-p194@email_lists"
set :rvm_type,         :system

set :application,      'email_lists'

set :scm,              :git
set :repository,       'git@git.111min.com:the111minutes/email_lists.git'
set :scm_passphrase,   ''

set :stages,           ["development"]
set :default_stage,    "development"
set :deploy_via,       :remote_cache

ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :use_sudo, false

set(:whenever_command) { "sudo RAILS_ENV=#{rails_env} bundle exec whenever --user root" }
set :whenever_environment, defer { stage }
require "whenever/capistrano"

namespace :deploy do

  desc "Start application"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec unicorn_rails -E #{rails_env} -c config/unicorn.rb -D"
  end

  desc "Stop application"
  task :stop, :roles => :app, :except => { :no_release => true }  do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  desc "Restart application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end

  desc "Create additional symlinks"
  task :symlink_configs, :role => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/unicorn.rb #{latest_release}/config/unicorn.rb"
    run "ln -nfs #{shared_path}/db/lists #{latest_release}/db/lists"
  end
end

namespace :assets do
  desc "Precompile assets"
  task :precompile do
    run_locally("bundle exec rake assets:clean && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}")
  end

  desc "Upload precompiled assets to webserver"
  task :upload, :roles => :app do
    top.upload( "public/assets", "#{latest_release}/public", :via => :scp, :recursive => true)
  end

  desc "Clean assets"
  task :clean do
    run_locally("bundle exec rake assets:clean")
  end
end

desc "View logs in real time"
namespace :logs do
  desc "Application log"
  task :application do
    watch_log("cd #{current_path} && tail -f log/#{rails_env}.log")
  end
end

after "deploy:update_code", "deploy:symlink_configs"
after "deploy:symlink_configs", "assets:precompile"
after "assets:precompile", "assets:upload"
after "assets:upload", "deploy:migrate"
after "deploy:migrate", "assets:clean"

# View logs helper
def watch_log(command)
  raise "Command is nil" unless command
  run command do |channel, stream, data|
    print data
    trap("INT") { puts 'Interupted'; exit 0; }
    break if stream == :err
  end
end
