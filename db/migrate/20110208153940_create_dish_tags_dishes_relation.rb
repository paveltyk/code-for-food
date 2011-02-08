class CreateDishTagsDishesRelation < ActiveRecord::Migration
  def self.up
    create_table :dish_tags_dishes, :id => false do |t|
      t.references :dish
      t.references :dish_tag
    end
  end

  def self.down
    drop_table :dish_tags_dishes
  end
end
