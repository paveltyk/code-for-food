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

end
