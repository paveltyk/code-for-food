module ApplicationHelper
  def render_errors_for(model)
    String.new.tap do |html|
      model.errors.full_messages.each do |msg|
        html << content_tag(:p, msg, :class => 'error')
      end
    end.html_safe
  end

  def render_flash_messages
    return '' if flash.blank?
    html = ''
    flash.each { |key, msg| html << content_tag(:div, msg, :class => key) }
    content_tag :div, html.html_safe, :class => 'flash'
  end
end

