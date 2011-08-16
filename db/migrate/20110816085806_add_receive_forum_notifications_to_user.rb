class AddReceiveForumNotificationsToUser < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def self.up
    add_column :users, :receive_forum_notifications, :boolean, :default => true
    User.update_all :receive_forum_notifications => true
  end

  def self.down
    remove_column :users, :receive_forum_notifications
  end
end

