class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :orders, :user_id
    add_index :orders, :menu_id
    add_index :menus, :administrator_id
    add_index :users, :invitation_id
    add_index :order_items, :order_id
    add_index :order_items, :dish_id
    add_index :invitations, :sender_id
    add_index :taggings, :dish_tag_id
    add_index :taggings, :dish_id
    add_index :dishes, :menu_id
  end

  def self.down
    remove_index :orders, :user_id
    remove_index :orders, :menu_id
    remove_index :menus, :administrator_id
    remove_index :users, :invitation_id
    remove_index :order_items, :order_id
    remove_index :order_items, :dish_id
    remove_index :invitations, :sender_id
    remove_index :taggings, :dish_tag_id
    remove_index :taggings, :dish_id
    remove_index :dishes, :menu_id
  end
end

