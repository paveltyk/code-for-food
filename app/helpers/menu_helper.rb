module MenuHelper
  def render_menu_calendar
    menu_calendar = MenuCalendar.new :dates => 3.days.ago.to_date..9.days.since.to_date

    html_items = menu_calendar.items.map do |item|
      path = nil

      if item.has_menu?
        path = order_path(:date => item.date.to_param) if current_user
      else
        path = new_menu_path(:date => item.date.to_param) if is_admin?
      end

      inner_html = path ? link_to(item.to_html, path) : content_tag(:p, item.to_html)
      dom_class = item.has_menu? ? 'active' : 'inactive'
      content_tag(:li, inner_html, :class => dom_class)
    end

    return content_tag(:ul, html_items.join.html_safe, :id => 'menu-calendar')
  end

  def render_menu_management_links(menu = nil)
    menu ||= @menu
    return unless menu
    links = []
    links << link_to('Редактировать меню', edit_menu_path(menu), :class => 'button')
    links << link_to('Отчет по заказам', menu, :class => 'button')
    links << link_to('Отчет по позициям', provider_report_for_menu_path(menu), :class => 'button')
    if menu.published?
      links << link_to('Заблокировать меню', lock_menu_path(menu), :class => 'button', :method => :put) unless menu.locked?
    else
      links << link_to('Опубликовать меню', publish_menu_path(menu), :class => 'button', :method => :put)
    end
    links.join(' ').html_safe
  end
end

