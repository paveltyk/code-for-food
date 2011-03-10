module TagHelper
  def render_tags(tags)
    html = tags.map do |tag|
      text = tag.name.to_s
      text << " #{'+' if tag.value > 0}#{number_with_delimiter tag.value}" if tag.value != 0
      content_tag :span, text, :title => tag.description, :class => 'tag'
    end
    html.to_s.html_safe
  end
end

