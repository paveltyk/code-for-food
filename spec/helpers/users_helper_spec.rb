require 'spec_helper'

describe UsersHelper do
  setup :activate_authlogic

  describe "#user_nav" do
    context "when not logged in" do
      before(:each) { helper.stub :current_user => nil }

      it "renders login link" do
        helper.user_nav.should match(/login/i)
      end
    end

    context "when logged in as User" do
      before(:each) { helper.stub :current_user => User.make, :is_admin? => false }

      it "renders logout link" do
        helper.user_nav.should match(/logout/i)
      end
    end

    context "when logged in as Administrator" do
      before(:each) { helper.stub :current_user => Administrator.make, :is_admin? => true }

      it "renders new menu link" do
        helper.user_nav.should match(new_menu_path)
      end

      it "renders tags link" do
        helper.user_nav.should match(dish_tags_path)
      end

      it "renders invitations link" do
        helper.user_nav.should match(new_invitation_path)
      end
    end
  end
end

