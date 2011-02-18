class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.references :user
      t.integer :price, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

