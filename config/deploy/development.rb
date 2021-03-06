server '209.208.78.126', :app, :web, :db, :primary => true
set :deploy_to,         "/var/www/email_lists"
set :unicorn_conf,      "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid,       "#{deploy_to}/shared/pids/unicorn.pid"

set :user,             'root'

set :rails_env,         "development"
set :branch,            "master"

set :rvm_path,         '/opt/rvm'
set :rvm_bin_path,     '/opt/rvm/bin'
