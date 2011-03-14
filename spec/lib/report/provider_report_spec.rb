require 'spec_helper'

describe Report::ProviderReport do
  let(:menu) { Menu.make! }
  let(:order) { Order.make! :menu => menu}
  let(:dish) { Dish.make! :menu => menu }

  context 'with 2 order items for the same dish' do
    before(:each) { 2.times { OrderItem.make! :dish => dish, :order => order } }

    it 'do not add same item twice' do
      Report::ProviderReport.new(menu).items.should have(2).elements
    end

    it 'summarize quantities for the same items' do
      Report::ProviderReport.new(menu).items.last.qtt.should eql 2
    end
  end
end

