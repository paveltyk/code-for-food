class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu
  has_many :order_items, :dependent => :destroy, :inverse_of => :order, :uniq => true
  has_many :dishes, :through => :order_items, :uniq => true

  validates_presence_of :user, :menu
end

