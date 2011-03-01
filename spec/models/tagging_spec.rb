require 'spec_helper'

describe Tagging do
  describe "validation" do
    def tagging(attrs = {})
      @tagging ||= Tagging.make attrs
    end

    it "valid" do
      Tagging.make.should be_valid
    end

    it "not valid if dish is blank" do
      tagging(:dish => nil).should_not be_valid
      tagging.should have_at_least(1).error_on(:dish)
    end

    it "not valid if dish_tag is blank" do
      tagging(:dish_tag => nil).should_not be_valid
      tagging.should have_at_least(1).error_on(:dish_tag)
    end
  end
end

