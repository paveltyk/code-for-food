require 'spec_helper'

describe Report::ProviderReport::Item do
  let(:order_item) { OrderItem.make! :quantity => 3 }
  let(:item) { Report::ProviderReport::Item.new order_item }

  it 'returns 3' do
    item.qtt.should eql 3
  end

  it 'returns dish name' do
    item.name.should eql order_item.dish.name
  end

  it 'returns dish total price' do
    item.dish_total_price.should eql order_item.dish.total_price
  end

  it 'return dish id' do
    item.dish_id.should eql order_item.dish_id
  end

  it 'return total price' do
    item.total_price.should eql order_item.dish.total_price * order_item.qtt
  end
end

