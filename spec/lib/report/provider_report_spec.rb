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

  it 'orders items by dish grade' do
    order = Order.make! :menu => menu
    Dish.destroy_all

    dish2 = Dish.make!(:menu => menu, :grade => 2)
    dish1 = Dish.make!(:menu => menu, :grade => 1)
    dish3 = Dish.make!(:menu => menu, :grade => 3)

    [dish3, dish1, dish2].each do |dish|
      OrderItem.make! :dish => dish, :order => order
    end

    report = Report::ProviderReport.new(menu)
    report.items.map(&:dish).should eq [dish1, dish2, dish3]
  end
end

