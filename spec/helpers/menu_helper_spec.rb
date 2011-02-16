require 'spec_helper'

describe MenuHelper do
  describe "#render_menu_calendar" do
    it "returns 13 menu items" do
      helper.render_menu_calendar.scan(/<li>.*?<\/li>/).should have(13).items
    end
    it "returns one active menu item" do
      Menu.destroy_all
      Menu.make! :date => Time.now
      helper.render_menu_calendar.scan(/class="active"/).should have(1).item
    end
  end
end

