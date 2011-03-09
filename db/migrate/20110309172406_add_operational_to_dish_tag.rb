class AddOperationalToDishTag < ActiveRecord::Migration
  def self.up
    add_column :dish_tags, :operational, :boolean, :default => true
  end

  def self.down
    remove_column :dish_tags, :operational
  end
end

