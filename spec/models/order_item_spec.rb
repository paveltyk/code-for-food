require 'spec_helper'

describe OrderItem do
  describe "validation" do
    it "valid" do
      OrderItem.make.should be_valid
    end

    it "not valid if dish is blank" do
      OrderItem.make(:dish => nil).tap do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:dish)
      end
    end

    it "not valid if order is blank" do
      OrderItem.make(:order => nil).tap do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:order)
      end
    end

    it "not valid if quantity is less then 1" do
      OrderItem.make(:quantity => 0).tap do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:quantity)
      end
    end

    it "not valid if quantity is greater than 99" do
      OrderItem.make(:quantity => 100).tap do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:quantity)
      end
    end

    it "not valid if quantity is not integer" do
      OrderItem.make(:quantity => 1.5).tap do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:quantity)
      end
    end

    it "not valid if dish doesn't belong to menu" do
      OrderItem.make(:dish => Dish.make!).tap do |oi|
        oi.should_not be_valid
        oi.errors.full_messages.should_not be_blank
      end
    end
  end
end

