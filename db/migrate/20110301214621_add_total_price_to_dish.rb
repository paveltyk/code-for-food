class AddTotalPriceToDish < ActiveRecord::Migration
  def self.up
    add_column :dishes, :total_price, :integer, :default => 0
  end

  def self.down
    remove_column :dishes, :total_price
  end
end

