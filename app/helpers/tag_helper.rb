module TagHelper
  def render_tags(tags)
    tags.map do |tag|
      text = tag.name.to_s
      text << " #{tag.value > 0 ? '+' : '-'}#{number_with_delimiter tag.value}" if tag.value != 0
      content_tag :span, text, :title => tag.description, :class => 'tag'
    end.to_s.html_safe
  end

end

