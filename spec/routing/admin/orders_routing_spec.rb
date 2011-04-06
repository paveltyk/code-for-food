require "spec_helper"

describe Admin::OrdersController do
  describe "routing" do
    it 'recognizes and generates #show' do
      { :get => "/admin/orders/1"}.should route_to(:controller => "admin/orders", :action => "show", :id => "1")
    end

    it 'recognizes and generates #edit' do
      { :get => "/admin/orders/1/edit"}.should route_to(:controller => "admin/orders", :action => "edit", :id => "1")
    end

    it 'recognizes and generates #update' do
      { :put => "/admin/orders/1"}.should route_to(:controller => "admin/orders", :action => "update", :id => "1")
    end

    it 'recognizes and generates #destroy' do
      { :delete => "/admin/orders/1"}.should route_to(:controller => "admin/orders", :action => "destroy", :id => "1")
    end
  end
end

