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

  describe 'mass assigment' do
    it 'assigns :body' do
      Feedback.new(:body => 'Hello').body.should eq 'Hello'
    end
    it 'not assigns sender' do
      Feedback.new(:sender => 'Hello').sender.should be_nil
    end
  end

  describe 'deliver' do
    let(:feedback) { Feedback.make }
    describe 'when not valid' do
      before(:each) { feedback.stub :valid? => false }

      it 'returns false' do
        feedback.deliver.should be_false
      end

      it 'does not sends out an email' do
        expect { feedback.deliver }.to_not change(ActionMailer::Base.deliveries, :count)
      end
    end

    describe 'when valid' do
      before(:each) { feedback.stub :valid? => true }

      it 'returns true' do
        feedback.deliver.should be_true
      end

      it 'sends out an email' do
        expect { feedback.deliver }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end
  end
end

