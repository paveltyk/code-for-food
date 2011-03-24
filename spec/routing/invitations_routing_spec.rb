require "spec_helper"

describe InvitationsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/invitations/new" }.should route_to(:controller => "invitations", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/invitations" }.should route_to(:controller => "invitations", :action => "create")
    end

    it "recoginzes and generates #resend" do
      { :put => "/invitations/1/resend" }.should route_to(:controller => "invitations", :action => "resend", :id => "1")
    end
  end
end

