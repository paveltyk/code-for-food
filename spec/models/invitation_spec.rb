require 'spec_helper'

describe Invitation do
  describe "#create" do
    it "generates token before create" do
      Invitation.make!.token.should_not be_blank
    end
  end

  describe "#validation" do
    it "valid" do
      Invitation.make.should be_valid
    end

    it "not valid if email is blank" do
      Invitation.make(:recipient_email => nil).should_not be_valid
    end

    it "not valid if email does not look like an email" do
      Invitation.make(:recipient_email => 'not_valid').should_not be_valid
    end

    it "not valid if sender is blank" do
      Invitation.make(:sender => nil).should_not be_valid
    end
  end

  describe "#discharged?" do
    let(:invitation) { Invitation.make }

    it "discharged when it has receiver" do
      invitation.stub_chain(:receiver, :present?).and_return(true)
      invitation.discharged?.should be_true
    end

    it "not discharged when it has no receiver" do
      invitation.stub_chain(:receiver, :present?).and_return(false)
      invitation.discharged?.should be_false
    end
  end
end

