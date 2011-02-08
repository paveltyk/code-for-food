class CreateDishes < ActiveRecord::Migration
  def self.up
    create_table :dishes do |t|
      t.references :menu
      t.string :name
      t.integer :price
      t.string :weight
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :dishes
  end
end
