require 'spec_helper'

describe Dish do
  it "valid" do
    Dish.make.should be_valid
  end

  it "not valid if name attr is blank" do
    Dish.make(:name => nil).should_not be_valid
  end

  it "not valid if price is blank" do
    Dish.make(:price => nil).should_not be_valid
  end

  it "not valid if price lower then 10" do
    Dish.make(:price => 9).should_not be_valid
  end

  it "not valid if menu is blank" do
    Dish.make(:menu => nil).should_not be_valid
  end

  describe "many-to-many relation with DishTag" do
    let(:dish) { Dish.make! }
    let(:tag) { DishTag.make! }

    it "adds new tag to tag list" do
      expect { dish.tags << tag }.to change(dish.tags, :count).from(0).to(1)
    end

    it "don't add same tag twice" do
      expect { 2.times { dish.tags << tag } }.to change(dish.tags, :count).from(0).to(1)
    end
  end

  describe "#total_price" do
    let(:dish) { Dish.make! }

    it "set total_price equal to price by default" do
      dish.total_price.should eql dish.price
    end

    it "includes tag values" do
      dish.tags << DishTag.make!(:value => 300)
      dish.reload.total_price.should eql(dish.price + 300)
    end

    it "doesn't use same tag twice" do
      tag = DishTag.make! :value => 300
      2.times { dish.tags << tag }
      dish.reload.total_price.should eql(dish.price + 300)
    end

    it "recalculates price after tag removed" do
      tag = DishTag.make! :value => 300
      dish.tags << tag
      dish.reload.total_price.should eql(dish.price + 300)
      dish.taggings.find_by_dish_tag_id(tag.id).destroy
      dish.reload.total_price.should eql(dish.price)
    end

    it 'recalculates price after tag removed via :tag_ids method' do
      tag = DishTag.make! :value => 300
      dish.tags << tag
      dish.reload.total_price.should eql(dish.price + 300)
      dish.tag_ids = []
      dish.save
      dish.reload.total_price.should eql(dish.price)
    end

  end

  describe "after price update" do
    it "recalculates prices for all related orders" do
      order = Order.make!
      order.order_items.first.dish.update_attribute :price, 100_000
      order.reload.price.should eql 100_000
    end
  end
end

