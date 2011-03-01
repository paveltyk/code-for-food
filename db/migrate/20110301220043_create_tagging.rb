class CreateTagging < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.references :dish_tag
      t.references :dish
    end

    drop_table :dish_tags_dishes
  end

  def self.down
    drop_table :taggings

    create_table :dish_tags_dishes, :id => false do |t|
      t.references :dish
      t.references :dish_tag
    end
  end
end

