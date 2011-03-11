require 'spec_helper'

describe MenuHelper do
  describe "#render_menu_calendar" do

    context "when not loggedin" do
      before :each do
        helper.stub :current_user => nil, :is_admin? => false
        Menu.destroy_all
        @menu = Menu.make! :date => Time.now
      end

      it "returns 13 menu items" do
        helper.render_menu_calendar.scan(/<li>.*?<\/li>/).should have(13).items
      end

      it "returns one active menu item" do
        helper.render_menu_calendar.scan(/class="active"/).should have(1).item
      end

      it "returns only one link for new order" do
        helper.render_menu_calendar.scan(new_order_path @menu).should have(1).item
      end

      it "returns 12 paragraps for the rest dates" do
        helper.render_menu_calendar.scan(/<li><p.*?>.*?<\/p><\/li>/).should have(12).items
      end
    end

    context "when loggedin as a regular user" do
      before :each do
        helper.stub :current_user => User.make!, :is_admin? => false
        Menu.destroy_all
        @menu = Menu.make! :date => Time.now
      end

      it "returns 13 menu items" do
        helper.render_menu_calendar.scan(/<li>.*?<\/li>/).should have(13).items
      end

      it "returns one active menu item" do
        helper.render_menu_calendar.scan(/class="active"/).should have(1).item
      end

      it "returns only one link for new order" do
        helper.render_menu_calendar.scan(new_order_path @menu).should have(1).item
      end

      it "returns 12 paragraps for the rest dates" do
        helper.render_menu_calendar.scan(/<li><p.*?>.*?<\/p><\/li>/).should have(12).items
      end

      it "returns a link to show if menu is locked" do
        @menu.update_attribute :locked, true
        helper.render_menu_calendar.scan(/href="#{order_path @menu}"/).should have(1).item
      end
    end

    context "when loggedin as administrator" do
      before :each do
        helper.stub :current_user => Administrator.make!, :is_admin? => true
        Menu.destroy_all
        @menu = Menu.make! :date => Time.now
      end

      it "returns 13 menu items" do
        helper.render_menu_calendar.scan(/<li>.*?<\/li>/).should have(13).items
      end

      it "returns one active menu item" do
        helper.render_menu_calendar.scan(/class="active"/).should have(1).item
      end

      it "returns only one link for new order" do
        helper.render_menu_calendar.scan(new_order_path @menu).should have(1).item
      end

      it "returns 12 links to create new menu" do
        helper.render_menu_calendar.scan(/<li><a.*?class=".*?inactive.*?".*?>.*?<\/a><\/li>/).should have(12).items
      end
    end
  end

  describe '#render_menu_management_links' do
    let(:menu) { Menu.make! }

    it 'returns html_safe string' do
      helper.render_menu_management_links(menu).should be_html_safe
    end

    it 'has 4 links' do
      helper.render_menu_management_links(menu).scan(/<a/).should have(4).items
    end
  end
end

