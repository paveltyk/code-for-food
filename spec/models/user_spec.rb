require 'spec_helper'

describe User do
  describe "#validation" do
    it "valid" do
      User.make.should be_valid
    end

    it "not valid if email is blank" do
      User.make(:email => nil).should_not be_valid
    end

    it "not valid if email does not look like an email address" do
      User.make(:email => 'bad emal').should_not be_valid
    end

    it "not valid if password is blank" do
      User.make(:password => nil).should_not be_valid
    end

    it "not valid if password is too short" do
      User.make(:password => '123').should_not be_valid
    end
  end
end

