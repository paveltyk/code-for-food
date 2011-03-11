require "spec_helper"

describe OrdersController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/2010-11-23/order/new" }.should route_to(:controller => "orders", :action => "new", :date => "2010-11-23")
    end

    it "recognizes and generates #create" do
      { :post => "/2010-11-23/order" }.should route_to(:controller => "orders", :action => "create", :date => "2010-11-23")
    end

    it "recognizes and generates #update" do
      { :put => "/2010-11-23/order" }.should route_to(:controller => "orders", :action => "update", :date => "2010-11-23")
    end

    it "recognizes and generates #show" do
      { :get => "/2010-11-23/order" }.should route_to(:controller => "orders", :action => "show", :date => "2010-11-23")
    end

    it "recognizes and generates #show as root path" do
      { :get => "/" }.should route_to(:controller => "orders", :action => "show", :date => "today")
    end
  end
end

