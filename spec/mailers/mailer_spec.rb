require "spec_helper"

describe Mailer do
  describe "invitation" do
    let(:invitation) { Invitation.make! }
    let(:mail) { Mailer.invitation(invitation) }

    it "renders the headers" do
      mail.subject.should eq("Your invitation to join \"Code for Food\" meal ordering system")
      mail.to.should eq([invitation.recipient_email])
      mail.from.should eq([invitation.sender.email])
    end

    it "renders the body" do
      mail.body.encoded.should match(register_url(:invitation_token => invitation.token))
    end
  end

end

