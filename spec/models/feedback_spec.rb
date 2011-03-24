require 'spec_helper'

describe Feedback do
  it_should_behave_like "ActiveModel"

  describe "validation" do
    let(:feedback) { Feedback.make }

    it 'valid' do
      feedback.should be_valid
    end

    it 'not valid if body is blank' do
      feedback.body = nil
      feedback.should_not be_valid
      feedback.should have_at_least(1).error_on(:body)
    end

    it 'not valid if sender' do
      feedback.sender = nil
      feedback.should_not be_valid
      feedback.should have_at_least(1).error_on(:sender)
    end
  end
end

