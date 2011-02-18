require 'spec_helper'

describe InvitationObserver do
  before(:each) { InvitationObserver.instance }

  describe "#after_create" do
    it "sends an email" do
      expect { Invitation.make! }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end

