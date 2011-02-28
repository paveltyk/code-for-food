require 'spec_helper'

describe TagsController do
  describe "routing" do
    it "recognizes and generates #index" do
    { :get => '/tags'}.should route_to(:controller => "tags", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => '/tags/new'}.should route_to(:controller => "tags", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => '/tags'}.should route_to(:controller => "tags", :action => "create")
    end
  end
end

