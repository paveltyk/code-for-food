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
        helper.render_menu_calendar.scan(/<li[^>]*>.*?<\/li>/).should have(13).items
      end

      it "returns one active menu item if menu published" do
        @menu.publish!
        helper.render_menu_calendar.scan(/class="[^"]*active[^"]*"/).should have(1).item
      end

      it "returns zero active menu item if menu not published" do
        helper.render_menu_calendar.scan(/class="[^"]*active[^"]*"/).should have(0).item
      end

      it "returns only zero link for order" do
        helper.render_menu_calendar.should_not match order_path(@menu)
      end

      it "returns 13 paragraps for the rest dates" do
        helper.render_menu_calendar.scan(/<li[^>]*><p.*?>.*?<\/p><\/li>/).should have(13).items
      end
    end

    context "when loggedin as a regular user" do
      before :each do
        helper.stub :current_user => User.make!, :is_admin? => false
        Menu.destroy_all
        @menu = Menu.make! :date => Time.now
      end

      it "returns 13 menu items" do
        helper.render_menu_calendar.scan(/<li[^>]*>.*?<\/li>/).should have(13).items
      end

      context 'with published menu' do
        before(:each) { @menu.publish! }

        it "returns one active menu item" do
          helper.render_menu_calendar.scan(/class="[^"]*active[^"]*"/).should have(1).item
        end

        it "returns only one link for order" do
          helper.render_menu_calendar.scan(order_path @menu).should have(1).item
        end

        it "returns 12 paragraps for the rest dates" do
          helper.render_menu_calendar.scan(/<li[^>]*><p.*?>.*?<\/p><\/li>/).should have(12).items
        end
      end

      context 'with unpublished menu' do
        it "returns zero active menu items" do
          helper.render_menu_calendar.scan(/class="[^"]*active[^"]*"/).should have(0).item
        end

        it "returns 13 paragraps for the rest dates" do
          helper.render_menu_calendar.scan(/<li[^>]*><p.*?>.*?<\/p><\/li>/).should have(13).items
        end
      end
    end

    context "when loggedin as administrator" do
      before :each do
        helper.stub :current_user => Administrator.make!, :is_admin? => true
        Menu.destroy_all
        @menu = Menu.make! :date => Time.now
      end

      it "returns 13 menu items" do
        helper.render_menu_calendar.scan(/<li[^>]*>.*?<\/li>/).should have(13).items
      end

      it "returns one active menu item" do
        helper.render_menu_calendar.scan(/class="[^"]*active[^"]*"/).should have(1).item
      end

      it "returns only one link for new order" do
        helper.render_menu_calendar.scan(order_path @menu).should have(1).item
      end

      it "returns 12 links to create new menu" do
        helper.render_menu_calendar.scan(new_menu_path).should have(12).items
      end
    end
  end

  describe '#render_menu_management_links' do
    let(:menu) { Menu.make! }
    let(:helper_str) { helper.render_menu_management_links(menu) }

    it 'returns html_safe string' do
      helper_str.should be_html_safe
    end

    it 'has edit menu link' do
      helper_str.should match edit_menu_path(menu)
    end

    it 'has menu orders report link' do
      helper_str.should match menu_path(menu)
    end

    it 'has menu provider report link' do
      helper_str.should match provider_report_for_menu_path(menu)
    end

    context 'when menu locked' do
      before(:each) { menu.update_attribute :locked, true }

      it 'does not have lock menu link' do
        helper_str.should_not match lock_menu_path(menu)
      end
    end

    context 'when menu not published' do
      it 'does not have lock menu link' do
        helper_str.should_not match lock_menu_path(menu)
      end

      it 'has publish menu link' do
        helper_str.should match publish_menu_path(menu)
      end
    end

    context 'when menu published' do
      before(:each) { menu.publish! }

      it 'has lock menu link' do
        helper_str.should match lock_menu_path(menu)
      end

      it 'does not have publish menu link' do
        helper_str.should_not match publish_menu_path(menu)
      end
    end
  end
end

