class MenuHelper::MenuCalendar

  def initialize(options = {})
    @dates = options[:dates]
    @menus = Menu.where(:date => @dates).all
  end

  def items
    @dates.map do |date|
      Item.new(date).tap do |item|
        item.menu = @menus.select{ |m| m.date == date }.first
      end
    end
  end

  class Item
    attr_accessor :menu, :date

    def initialize(date)
      @date = date
    end

    def has_menu?
      menu.present?
    end

    def status
      if menu.locked?
        'locked'
      elsif menu.published?
        'published'
      else
        ''
      end
    end

    def to_html
      Russian::strftime(@date, "<b>%a<span class=\"icon m1\"></span><span class=\"icon m2\"></span><span class=\"icon m3\"></span></b><em>%B</em>%d").html_safe
    end
  end
end

