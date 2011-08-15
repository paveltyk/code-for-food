class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :type
      t.integer :user_id
      t.text :body
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

