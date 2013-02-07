class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :lead_date
      t.string :url
      t.string :ip
      t.boolean :added

      t.timestamps
    end
  end
end
