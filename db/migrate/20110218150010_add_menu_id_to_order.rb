class AddMenuIdToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :menu_id, :integer
  end

  def self.down
    remove_column :orders, :menu_id
  end
end

