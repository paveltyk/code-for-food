require 'spec_helper'

describe Order do
  describe "validation" do
    it "valid" do
      Order.make.should be_valid
    end

    it "not valid if user is blank" do
      Order.make(:user => nil).should_not be_blank
    end
  end
end

