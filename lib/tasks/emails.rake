namespace :emails do
  desc "Grab all not_added subscribers and save to file email_list.csv"
  task :export_to_csv => :environment do
    Subscriber.export_emails_to_csv
  end

  desc "Mark uploaded emails as added"
  task :update_added => :environment do
    Subscriber.update_added_emails
  end
end
