module ApplicationHelper
  def render_errors_for(model)
    String.new.tap do |html|
      model.errors.full_messages.each do |msg|
        html << content_tag(:p, msg, :class => 'error')
      end
    end.html_safe
  end
end

