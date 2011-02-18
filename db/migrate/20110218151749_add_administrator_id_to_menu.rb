class AddAdministratorIdToMenu < ActiveRecord::Migration
  def self.up
    add_column :menus, :administrator_id, :integer
  end

  def self.down
    remove_column :menus, :administrator_id
  end
end

