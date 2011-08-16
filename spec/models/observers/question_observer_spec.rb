require 'spec_helper'

describe QuestionObserver do
  before(:each) { QuestionObserver.instance }

  describe 'after question posted' do
    it 'sends out an email to users who want to get forum notification' do
      User.make! :receive_forum_notifications => false
      expect {
        Question.make!
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end

