require "spec_helper"

describe PasswordResetsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/password_resets/new" }.should route_to(:controller => "password_resets", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/password_resets" }.should route_to(:controller => "password_resets", :action => "create")
    end
  end
end

