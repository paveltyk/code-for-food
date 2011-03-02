class DishObserver < ActiveRecord::Observer
  observe Dish

  def after_update(dish)
    return unless dish.total_price_changed?
    dish.orders.each(&:update_price!)
  end
end

