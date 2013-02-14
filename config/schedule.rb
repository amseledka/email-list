set :output, "log/cron_log.log"

every :day, :at => '11:00pm' do
  runner "Subscriber.export_emails_to_csv"
  rake "spec"
  runner "Subscriber.update_added_emails"
end
