class OrderItem < ActiveRecord::Base
  belongs_to :dish
  belongs_to :order

  validates_presence_of :dish, :order
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
end

