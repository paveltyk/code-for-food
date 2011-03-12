require "spec_helper"

describe MenusController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/menus/2010-11-23" }.should route_to(:controller => "menus", :action => "show", :id => "2010-11-23")
    end

    it "recognizes and generates #new" do
      { :get => "/menus/new" }.should route_to(:controller => "menus", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/menus" }.should route_to(:controller => "menus", :action => "create")
    end

    it "recognizes and generates #edit" do
      { :get => "/menus/2010-11-23/edit" }.should route_to(:controller => "menus", :action => "edit", :id => "2010-11-23")
    end

    it "recognizes and generates #update" do
      { :put => "/menus/2010-11-23" }.should route_to(:controller => "menus", :action => "update", :id => "2010-11-23")
    end

    it "recognizes and generates #lock" do
      { :put => "/menus/2010-11-23/lock" }.should route_to(:controller => "menus", :action => "lock", :id => "2010-11-23")
    end

    it "recognizes and generates #publish" do
      { :put => "/menus/2010-11-23/publish" }.should route_to(:controller => "menus", :action => "publish", :id => "2010-11-23")
    end
  end
end

