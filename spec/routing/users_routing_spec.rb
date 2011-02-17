require "spec_helper"

describe UsersController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/register/token" }.should route_to(:controller => "users", :action => "new", :invitation_token => 'token')
    end

    it "recognizes and generates #create" do
      { :post => "/register" }.should route_to(:controller => "users", :action => "create")
    end
  end
end

