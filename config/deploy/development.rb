server '172.17.16.30', :app, :web, :db, :primary => true
set :deploy_to,         "/var/www/email_lists"
set :unicorn_conf,      "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid,       "#{deploy_to}/shared/pids/unicorn.pid"

set :user,             'root'

set :rails_env,         "development"
set :branch,            "develop"

set :rvm_path,         '/opt/rvm'
set :rvm_bin_path,     '/opt/rvm/bin'
