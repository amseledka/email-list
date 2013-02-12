class AddDefaultValueToAddedToSubscribers < ActiveRecord::Migration
  def change
    change_column :subscribers, :added, :boolean, :default => false
  end
end
