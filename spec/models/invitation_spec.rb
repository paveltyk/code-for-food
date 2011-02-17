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
  end
end

