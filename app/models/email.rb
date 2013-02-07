class Email < ActiveRecord::Base
  attr_accessible :added, :email, :first_name, :ip, :last_name, :lead_date, :url
end
