require 'spec_helper'

describe Menu do
  it "valid" do
    Menu.make.should be_valid
  end

  it "not be valid if date is blank" do
    Menu.make(:date => nil).should_not be_valid
  end

  it "not valid if date is not unique" do
    menu = Menu.make!
    Menu.make(:date => menu.date).should_not be_valid
  end

  it "set locked attr to false by default" do
    Menu.make.should_not be_locked
  end
end
