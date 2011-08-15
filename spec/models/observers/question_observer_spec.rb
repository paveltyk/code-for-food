require 'spec_helper'

describe QuestionObserver do
  before(:each) { QuestionObserver.instance }

  describe 'after question posted' do
    it 'sends out an email' do
      expect {
        Question.make!
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end

