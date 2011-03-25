require "spec_helper"

describe Admin::MenusController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/admin/menus/2010-11-23" }.should route_to(:controller => "admin/menus", :action => "show", :id => "2010-11-23")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/menus/new" }.should route_to(:controller => "admin/menus", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/menus" }.should route_to(:controller => "admin/menus", :action => "create")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/menus/2010-11-23/edit" }.should route_to(:controller => "admin/menus", :action => "edit", :id => "2010-11-23")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/menus/2010-11-23" }.should route_to(:controller => "admin/menus", :action => "update", :id => "2010-11-23")
    end

    it "recognizes and generates #lock" do
      { :put => "/admin/menus/2010-11-23/lock" }.should route_to(:controller => "admin/menus", :action => "lock", :id => "2010-11-23")
    end

    it "recognizes and generates #publish" do
      { :put => "/admin/menus/2010-11-23/publish" }.should route_to(:controller => "admin/menus", :action => "publish", :id => "2010-11-23")
    end
  end
end

