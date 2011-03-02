require 'spec_helper'

describe Order do
  describe "validation" do
    it "valid" do
      Order.make.should be_valid
    end

    it "not valid if user is blank" do
      Order.make(:user => nil).should_not be_valid
    end

    it "not valid if menu is blank" do
      Order.make(:menu => nil).should_not be_valid
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
    end

    describe "price calculation" do
      it "calculates price as sum of dish prices" do
        menu.dishes.each { |dish| order.order_items.build :dish => dish }
        order.valid?
        order.price.should eql(menu.dishes.sum(:price))
      end

      it "uses quantity as multiplier" do
        dish = menu.dishes.first
        order.order_items.build :dish => dish, :quantity => 10
        order.valid?
        order.price.should eql(dish.price * 10)
      end

      xit "caclculates tag value as well" do
        dish = menu.dishes.first
        dish.tags << DishTag.make!(:value => 700)
        order.order_items.build :dish => dish
        order.valid?
        order.price.should eql(dish.price + 700)
      end
    end
  end
end

