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

    context "when logged in" do
      before(:each) { helper.stub :current_user => User.make }

      it "renders logout link" do
        helper.user_nav.should match(/logout/i)
      end
    end
  end
end

