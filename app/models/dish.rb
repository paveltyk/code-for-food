class Dish < ActiveRecord::Base
  belongs_to :menu
  has_many :taggings, :inverse_of => :dish, :dependent => :destroy
  has_many :tags, :through => :taggings, :source => :dish_tag, :uniq => true
  has_many :order_items, :dependent => :destroy, :inverse_of => :dish, :uniq => true
  has_many :orders, :through => :order_items, :uniq => true

  validates_presence_of :name, :price, :menu
  validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 10

  before_save :update_total_price, :if => "price_changed?"
  #after_update :update_price_in_related_orders, :if => "price_changed?"

  def update_total_price
    self.total_price = price + tags(true).all.sum(&:value)
  end

  def update_total_price!
    update_total_price
    save
  end

  private

  def update_price_in_related_orders
    self.orders.each { |order| order.send(:calculate_price); order.save }
  end
end

