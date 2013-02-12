class Subscriber < ActiveRecord::Base
  attr_accessible :added, :email, :first_name, :ip, :last_name, :lead_date, :url
  validates :email, :uniqueness => true, :presence => true
  validates_format_of :email, :with  => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
end
