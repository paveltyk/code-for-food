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
end

