class OrderItem < ActiveRecord::Base
  attr_accessor :is_ordered

  belongs_to :dish
  belongs_to :order

  validates_presence_of :dish, :order
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validate :dish_belongs_to_menu, :if => "order.try(:menu) && dish.try(:menu)"

  private

  def dish_belongs_to_menu
    errors.add(:base, 'Dish does not belongs to menu') if self.dish.menu != self.order.menu
  end
end

