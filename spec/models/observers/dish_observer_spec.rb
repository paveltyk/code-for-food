require 'spec_helper'

describe DishObserver do
  before(:each) { DishObserver.instance }
  let(:order_item) { Order.make!.order_items.first }

  it "updates order price" do
    order_item.dish.update_attribute :total_price, 3000
    order_item.order.reload.price.should eql 3000
  end
end

