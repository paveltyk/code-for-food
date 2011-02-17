require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/login" }.should route_to(:controller => "sessions", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/login" }.should route_to(:controller => "sessions", :action => "create")
    end

    it "recognizes and generates #destroy" do
      { :get => "/logout" }.should route_to(:controller => "sessions", :action => "destroy")
    end
  end
end

