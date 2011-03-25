class AddGradeToDish < ActiveRecord::Migration
  def self.up
    change_table :dishes do |t|
      t.string :grade
    end
  end

  def self.down
    remove_column :dishes, :grade
  end
end

