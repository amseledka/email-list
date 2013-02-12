class RenameEmailsToSubscribers < ActiveRecord::Migration
  def up
    rename_table :emails, :subscribers
  end

  def down
    rename_table :subscribers, :emails
  end
end
