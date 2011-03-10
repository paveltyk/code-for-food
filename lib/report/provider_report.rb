class Report::ProviderReport
  attr_reader :menu, :orders, :total_price, :items

  def initialize(menu)
    @menu = menu
    @orders = self.menu.orders
    @total_price = self.orders.sum(:price)
    @items = []
    load_items
  end

  def add_item(order_item)
    if item = self.items.select{ |i| i.dish_id == order_item.dish_id }.first
      item.qtt += order_item.qtt
    else
      self.items << Item.new(order_item)
    end
  end

  def load_items
    @items = []
    OrderItem.where(:order_id => orders).each do |oi|
      add_item(oi)
    end
  end
  private :load_items

  class Item
    attr_accessor :dish_id, :dish_total_price, :name, :qtt

    def initialize(order_item)
      @dish_id = order_item.dish_id
      @dish_total_price = order_item.dish.total_price
      @name = order_item.dish.name
      @qtt = order_item.qtt
    end

    def total_price
      dish_total_price * qtt
    end
  end
end

