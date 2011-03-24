require 'spec_helper'

describe "Invitations" do
  setup :activate_authlogic
  before(:each) { UserSession.create Administrator.make! }

  describe "PUT /invitations/:id/resend" do
    let(:invitation) { Invitation.make! }

    it "sends an email" do
      expect {
        get resend_invitation_path(invitation)
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end

