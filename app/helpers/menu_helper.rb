module MenuHelper
  def render_menus_menu
    html = ''
    time_range = 3.days.ago.to_date..-9.days.ago.to_date
    time_range.each do |date|
      link_html = link_to(date.strftime("<b>%d</b><em>%B</em>%A").html_safe, '#')
      html << content_tag(:li, link_html)
    end
    content_tag(:ul, html.html_safe, :id => 'menu-calendar')
  end
end

