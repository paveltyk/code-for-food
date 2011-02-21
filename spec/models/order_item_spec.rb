require 'spec_helper'

describe OrderItem do
  describe "validation" do
    it "valid" do
      OrderItem.make.should be_valid
    end

    it "not valid if dish is blank" do
      OrderItem.make(:dish => nil).should_not be_valid
    end

    it "not valid if order is blank" do
      OrderItem.make(:order => nil).should_not be_valid
    end

    it "not valid if quantity is less then 1" do
      OrderItem.make(:quantity => 0).should_not be_valid
    end

    it "not valid if quantity is not integer" do
      OrderItem.make(:quantity => 1.5).should_not be_valid
    end
  end
end

