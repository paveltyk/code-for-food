require 'spec_helper'

describe Order do
  describe "validation" do
    let(:order) { Order.make }
    it "valid" do
      order.should be_valid
    end

    it "not valid if user is blank" do
      order.user = nil
      order.should_not be_valid
      order.should have_at_least(1).error_on(:user)
    end

    it "not valid if menu is blank" do
      order.menu = nil
      order.should_not be_valid
      order.should have_at_least(1).error_on(:menu)
    end

    it "not valid if there is no order items" do
      order.order_items = []
      order.should_not be_valid
      order.should have_at_least(1).error_on(:base)
    end
  end

  describe "menu_items" do
    let(:menu) { Menu.make!(:with_3_dishes) }
    let(:order) { Order.make :menu => menu }

    it "generates 3 menu items" do
      order.menu_items.should have(3).items
    end

    it "generates menu item for each dish" do
      menu.dishes.each do |dish|
        order.menu_items.map(&:dish_id).should include(dish.id)
      end
    end

    describe "accepts nested attributes for menu_items" do
      let(:attrs_for_first_dish) { { :dish_id => menu.dishes.first.id, :quantity => 1, :is_ordered => '1'} }

      it "builds one order_item" do
        order.menu_items_attributes = { "0" => attrs_for_first_dish }
        order.order_items.should have(1).item
      end

      it "builds none order_items" do
        order.menu_items_attributes = { "0" => attrs_for_first_dish.merge(:is_ordered => '0') }
        order.order_items.should have(0).item
      end

      it "not fails if ordered menu_item quantity is nil" do
        order.menu_items_attributes = { "0" => attrs_for_first_dish.merge(:is_ordered => '1', :quantity => nil) }
        order.order_items.should have(1).item
        expect { order.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe "price calculation" do
      it "calculates price as sum of dish total_prices" do
        menu.dishes.each { |dish| order.order_items.build :dish => dish }
        order.valid?
        order.price.should eql(menu.dishes.sum(:total_price))
      end

      it "uses quantity as multiplier" do
        dish = menu.dishes.first
        order.order_items.build :dish => dish, :quantity => 10
        order.valid?
        order.price.should eql(dish.total_price * 10)
      end
    end
  end
end

