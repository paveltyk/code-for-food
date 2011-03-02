class DishTagObserver < ActiveRecord::Observer
  observe DishTag

  def after_update(tag)
    return unless tag.value_changed?
    tag.dishes.each(&:update_total_price!)
  end
end

