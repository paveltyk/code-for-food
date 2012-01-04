class MenuObserver < ActiveRecord::Observer
  observe Menu

  def after_update(menu)
    if menu.published_at_changed? && menu.published_at_was.nil?
      User.where(:receive_notifications => true).all.in_groups_of(20) do |users|
        Mailer.menu_published(menu, users).deliver
      end
    end
  end
end

