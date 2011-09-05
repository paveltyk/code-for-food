# encoding: utf-8

class OrderItemObserver < ActiveRecord::Observer
  observe OrderItem

  def after_destroy(order_item)
    order_item.order.update_price!
  end
end

