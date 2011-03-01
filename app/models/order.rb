class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu
  has_many :order_items, :dependent => :destroy, :inverse_of => :order, :uniq => true
  has_many :dishes, :through => :order_items, :uniq => true

  validates_presence_of :user, :menu

  after_validation :calculate_price

  def menu_items
    menu.dishes.map do |dish|
      existent_oi = self.order_items.select{ |oi| oi.dish_id == dish.id }.first
      existent_oi ? existent_oi.tap { |oi| oi.is_ordered = true } : order_items.new(:dish => dish)
    end
  end

  def menu_items_attributes=(attributes)
    attributes = attributes.delete_if{ |k,v| v[:is_ordered] != '1' }.map { |attrs| attrs[1] }
    self.order_items = attributes.map { |attrs| self.order_items.new attrs }
  end

  private

  def calculate_price
    self.price = self.order_items.map{ |oi| oi.dish.total_price * oi.quantity }.sum
  end
end

