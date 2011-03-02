class TaggingObserver < ActiveRecord::Observer
  observe Tagging

  def after_create(tagging)
    tagging.dish.update_total_price!
  end

  def after_destroy(tagging)
    tagging.dish.update_total_price!
  end
end

