set :output, "log/cron_log.log"
set :environment, 'development'
set :job_template, "bash -l -i -c ':job'"
job_type :runner, 'rvm use 1.9.3-p194@email_lists --create && cd :path && bundle exec script/rails runner -e :environment ":task" :output'
job_type :rake, 'rvm use 1.9.3-p194@email_lists --create && cd :path && RAILS_ENV=:environment bundle exec rake :task --silent :output'


every :day, :at => '12:00pm' do
  rake 'emails:export_to_csv'
end

every :day :at => '12:15pm' do
  rake "spec"
end

every :day, :at => '12:40pm' do
  rake "emails:update_added"
end