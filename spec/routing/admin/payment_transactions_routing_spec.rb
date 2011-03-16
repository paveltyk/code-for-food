require "spec_helper"

describe Admin::PaymentTransactionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/users/uid/payment_transactions" }.should route_to(:controller => "admin/payment_transactions", :action => "index", :user_id => "uid")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/users/uid/payment_transactions/new" }.should route_to(:controller => "admin/payment_transactions", :action => "new", :user_id => "uid")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/users/uid/payment_transactions/1/edit" }.should route_to(:controller => "admin/payment_transactions", :action => "edit", :id => "1", :user_id => "uid")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/users/uid/payment_transactions" }.should route_to(:controller => "admin/payment_transactions", :action => "create", :user_id => "uid")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/users/uid/payment_transactions/1" }.should route_to(:controller => "admin/payment_transactions", :action => "update", :id => "1", :user_id => "uid")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/users/uid/payment_transactions/1" }.should route_to(:controller => "admin/payment_transactions", :action => "destroy", :id => "1", :user_id => "uid")
    end

  end
end

