require "spec_helper"

describe Admin::UsersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/users" }.should route_to(:controller => "admin/users", :action => "index")
    end

    it "recognizes and generates #index as root path" do
      { :get => "/admin" }.should route_to(:controller => "admin/users", :action => "index")
    end
  end
end

