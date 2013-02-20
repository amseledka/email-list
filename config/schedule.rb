set :output, "log/cron_log.log"
set :environment, 'development'
set :job_template, "bash -l -i -c ':job'"
job_type :runner, 'source /opt/rvm/environments/ruby-1.9.3-p194@email_lists && bundle install && cd :path && bundle exec script/rails runner -e :environment ":task" :output'

every :day, :at => '10:20am' do
  runner 'Subscriber.export_emails_to_csv'
  rake "spec"
  runner "Subscriber.update_added_emails"
end
