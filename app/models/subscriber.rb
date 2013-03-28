class Subscriber < ActiveRecord::Base
  attr_accessible :added, :email, :first_name, :ip, :last_name, :lead_date, :url
  validates :email, :uniqueness => true, :presence => true, :on => :create
  validates_format_of :email, :with  => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

  scope :not_added, where("added = false")

  def self.export_emails_to_csv
    @subscribers = Subscriber.not_added

    csv_string = CsvShaper::Shaper.encode do |csv|
      csv.headers do |csv|
        csv.columns :email, :first_name, :last_name, :ip
        csv.mappings :email => 'Email address', :first_name => 'fname', :last_name => 'lname', :lead_date => 'Subscribe date (yyyy/mm/dd)', :ip => 'Contacts ip address'
      end
      csv.rows @subscribers do |csv, subscriber|
        csv.cells :email, :first_name, :last_name, :lead_date
      end
    end

    file = "db/lists/email_list.csv"
    File.open(file, "w") { |file| file.write(csv_string) } 
  end

  def self.update_added_emails
    csv_text = File.read('db/lists/email_list.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      email = row.to_hash.with_indifferent_access["Email address"]
      Subscriber.where(:email => email).each do |s|
        s.update_attributes(:added => true)
      end
    end
  end
end
