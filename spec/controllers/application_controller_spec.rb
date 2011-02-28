require 'spec_helper'

describe ApplicationController do
  setup :activate_authlogic

  describe "#is_admin?" do
    it "returns true if current user is admin" do
      UserSession.create Administrator.make!
      controller.send(:is_admin?).should be_true
    end

    it "returns false if current user is regular user" do
      UserSession.create User.make!
      controller.send(:is_admin?).should be_false
    end

    it "returns false if not logged in" do
      controller.send(:is_admin?).should be_false
    end
  end
end

