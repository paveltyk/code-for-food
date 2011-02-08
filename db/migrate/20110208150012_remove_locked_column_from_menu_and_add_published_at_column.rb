class RemoveLockedColumnFromMenuAndAddPublishedAtColumn < ActiveRecord::Migration
  def self.up
    change_table :menus do |t|
      t.remove :locked
      t.datetime :published_at, :default => nil
    end
  end

  def self.down
    change_table :menus do |t|
      t.boolean :locked
      t.remove :published_at
    end
  end
end
