class CreateOrderItem < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.references :order
      t.references :dish
      t.integer :quantity, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end

