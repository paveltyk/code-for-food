class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.date :date
      t.boolean :locked, :default => false

      t.timestamps
    end
    add_index :menus, :date
  end

  def self.down
    drop_table :menus
  end
end
