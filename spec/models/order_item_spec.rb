require 'spec_helper'

describe OrderItem do
  describe "validation" do
    it "valid" do
      OrderItem.make.should be_valid
    end

    it "not valid if dish is blank" do
      OrderItem.make(:dish => nil) do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:dish)
      end
    end

    it "not valid if order is blank" do
      OrderItem.make(:order => nil) do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:order)
      end
    end

    it "not valid if quantity is less then 1" do
      OrderItem.make(:quantity => 0) do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:quantity)
      end
    end

    it "not valid if quantity is not integer" do
      OrderItem.make(:quantity => 1.5) do |oi|
        oi.should_not be_valid
        oi.should have_at_least(1).error_on(:quantity)
      end
    end
  end
end

