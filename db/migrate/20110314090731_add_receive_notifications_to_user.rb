class AddReceiveNotificationsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :receive_notifications, :boolean, :default => true
  end

  def self.down
    remove_column :users, :receive_notifications
  end
end

