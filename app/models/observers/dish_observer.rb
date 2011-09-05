# encoding: utf-8

class DishObserver < ActiveRecord::Observer
  observe Dish

  def after_update(dish)
    return unless dish.total_price_changed?
    dish.orders.each do |order|
      order.update_price!
      order.user.sweep_cached_totals
    end
  end
end

