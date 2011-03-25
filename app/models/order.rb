class Order < ActiveRecord::Base
  attr_accessible :menu_items_attributes

  belongs_to :user
  belongs_to :menu
  has_many :order_items, :dependent => :destroy, :inverse_of => :order, :uniq => true
  has_many :dishes, :through => :order_items, :uniq => true

  validates_presence_of :user, :menu
  validate :validate_order_items_quantity

  before_validation :update_price

  def menu_items
    menu.dishes.map do |dish|
      existent_oi = self.order_items.select{ |oi| oi.dish_id == dish.id }.first
      existent_oi ? existent_oi.tap { |oi| oi.is_ordered = true } : order_items.new(:dish => dish)
    end.sort { |a,b| (a.dish.grade || '') <=> (b.dish.grade || '') }
  end

  def menu_items_attributes=(attributes)
    attributes = attributes.delete_if{ |k,v| v[:is_ordered] != '1' }.map { |attrs| attrs[1] }
    self.order_items = attributes.map { |attrs| self.order_items.new attrs }
  end

  def update_price
    self.price = order_items.map{ |oi| (oi.dish.try(:total_price) || 0) * (oi.quantity || 0) }.sum
  end

  def update_price!
    update_price
    save
  end

  private

  def validate_order_items_quantity
    errors.add :base, 'Заказ не может быть пустым' if order_items.blank?
  end
end

