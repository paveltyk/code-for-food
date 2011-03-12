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

    def to_html
      Russian::strftime(@date, "<b>%a</b><em>%B</em>%d").html_safe
    end
  end
end

