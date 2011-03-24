require 'spec_helper'

describe InvitationHelper do
  def mock_invitation(stubs={})
    @mock_invitation ||= mock_model(Invitation, stubs).as_null_object
  end

  describe "#invitation_status_link" do
    context "when invitation discharged" do
      before(:each) { mock_invitation :discharged? => true, :receiver => user }
      let(:user) { User.make! }

      it "renders user path" do
        helper.invitation_status_link(mock_invitation).should include(admin_user_path(user))
      end
    end

    context "when invitation pending" do
      before(:each) { mock_invitation :discharged? => false }

      it "renders resend invitation path" do
        helper.invitation_status_link(mock_invitation).should include(resend_invitation_path(mock_invitation))
      end
    end
  end
end

