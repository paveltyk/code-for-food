class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu
  has_many :order_items, :dependent => :destroy, :inverse_of => :order
  has_many :dishes, :through => :order_items

  validates_presence_of :user, :menu
end

