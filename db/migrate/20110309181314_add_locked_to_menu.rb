class AddLockedToMenu < ActiveRecord::Migration
  def self.up
    add_column :menus, :locked, :boolean
  end

  def self.down
    remove_column :menus, :locked
  end
end

