require 'spec_helper'

describe Menu do
  it "valid" do
    Menu.make.should be_valid
  end

  it "not valid if date is blank" do
    Menu.make(:date => nil).should_not be_valid
  end

  it "not valid if date is not unique" do
    menu = Menu.make!
    Menu.make(:date => menu.date).should_not be_valid
  end

  it "not published by default" do
    Menu.make.should_not be_published
  end

  it "should return formatted date" do
    date = Time.now.to_date
    Menu.make(:date => date).to_s.should eql(date.strftime("%A %d.%m"))
  end

  it "should return \"unknown\" text if date is nil" do
     Menu.make(:date => nil).to_s.should eql("unknown")
  end

  describe "#publish!" do
    let(:menu) { Menu.make! }
    it "set published_at value" do
      expect { menu.publish! }.to change(menu, :published_at).from(nil)
    end
  end

end

