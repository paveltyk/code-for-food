class Dish < ActiveRecord::Base
  belongs_to :menu
  has_and_belongs_to_many :tags, :class_name => 'DishTag', :uniq => true
  has_many :order_items, :dependent => :destroy, :inverse_of => :dish, :uniq => true
  has_many :orders, :through => :order_items, :uniq => true

  validates_presence_of :name, :price, :menu
  validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 10

  def total_price
    self.price + self.tags.sum(:value)
  end
end

