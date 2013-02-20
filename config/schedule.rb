set :output, "log/cron_log.log"
set :environment, 'development' 
job_type :runner, 'cd :path && bundle exec script/rails runner -e :environment ":task" :output'

every :day, :at => '9:38am' do
  runner 'Subscriber.export_emails_to_csv'
  rake "spec"
  runner "Subscriber.update_added_emails"
end
