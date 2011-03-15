module TagHelper
  def render_tags(tags)
    html = tags.map do |tag|
      content_tag :span, tag.name, :title => tag.description, :class => 'tag'
    end
    html.to_s.html_safe
  end
end

