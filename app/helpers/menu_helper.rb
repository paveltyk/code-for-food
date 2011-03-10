module MenuHelper
  def render_menu_calendar
    html = ''
    time_range = 3.days.ago.to_date..-9.days.ago.to_date
    menus = Menu.where(:date => time_range).all
    menu_dates = menus.map(&:date)
    time_range.each do |date|
      item_text = Russian::strftime(date, "<b>%a</b><em>%B</em>%d").html_safe
      if menu_dates.include?(date)
        if menus.select{ |m| m.date == date}.first.try(:locked?)
          link_path = order_path(:date => date.to_param)
          item_dom_class =  'active'
        else
          link_path = new_order_path(:date => date.to_param)
          item_dom_class =  'active'
        end
      elsif is_admin?
        link_path = new_menu_path(:date => date.to_param)
        item_dom_class =  'inactive'
      else
        link_path = nil
        item_dom_class =  'inactive'
      end
      if link_path
        item_html = link_to item_text, link_path, :class => item_dom_class
      else
        item_html = content_tag :p, item_text, :class => item_dom_class
      end
      html << content_tag(:li, item_html)
    end
    content_tag(:ul, html.html_safe, :id => 'menu-calendar')
  end
end

