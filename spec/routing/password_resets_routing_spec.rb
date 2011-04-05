require "spec_helper"

describe PasswordResetsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/password_resets/new" }.should route_to(:controller => "password_resets", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/password_resets" }.should route_to(:controller => "password_resets", :action => "create")
    end

    it "recognizes and generates #edit" do
      { :get => "password_resets/1/edit" }.should route_to(:controller => "password_resets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "password_resets/1" }.should route_to(:controller => "password_resets", :action => "update", :id => "1")
    end
  end
end

