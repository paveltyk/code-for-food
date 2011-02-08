class CreateDishTags < ActiveRecord::Migration
  def self.up
    create_table :dish_tags do |t|
      t.string :name
      t.integer :value, :default => 0
      t.string :weight
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :dish_tags
  end
end
