module MenuHelper
  def render_menu_calendar
    html = ''
    time_range = 3.days.ago.to_date..-9.days.ago.to_date
    menus = Menu.where(:date => time_range).all
    menu_dates = menus.map(&:date)
    time_range.each do |date|
      link_text = date.strftime("<b>%d</b><em>%B</em>%A").html_safe
      if menu_dates.include?(date)
        link_path = menu_path(menus.select { |m| m.date == date})
        link_dom_class =  'active'
      else
        link_path = new_menu_path(:date => date.to_param)
        link_dom_class =  'inactive'
      end
      link_html = link_to link_text, link_path, :class => link_dom_class
      html << content_tag(:li, link_html)
    end
    content_tag(:ul, html.html_safe, :id => 'menu-calendar')
  end
end

