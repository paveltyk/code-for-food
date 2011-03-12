class MenuObserver < ActiveRecord::Observer
  observe Menu

  def after_update(menu)
    if menu.published_at_changed? && menu.published_at_was.nil?
      Mailer.menu_published(menu).deliver
    end
  end
end

