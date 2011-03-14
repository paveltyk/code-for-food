require 'spec_helper'

describe OrderItemObserver do
  before(:each) { OrderItemObserver.instance }
  let(:order_item) { Order.make!.order_items.first }

  it "updates order price after order item removed" do
    order = order_item.order.tap(&:update_price!)
    expect { order_item.destroy }.to change(order.reload, :price).to(0)
  end
end

