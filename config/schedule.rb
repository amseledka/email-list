set :output, "log/cron_log.log"
set :environment, 'development'
set :job_template, "bash -l -i -c ':job'"
job_type :runner, 'rvm use 1.9.3-p194@email_lists --create && cd :path && bundle exec script/rails runner -e :environment ":task" :output'
job_type :rake, 'rvm use 1.9.3-p194@email_lists --create && cd :path && RAILS_ENV=:environment bundle exec rake :task --silent :output'


every :day, :at => '00:36am' do
  runner 'Subscriber.export_emails_to_csv'
  rake "spec"
  runner "Subscriber.update_added_emails"
end
