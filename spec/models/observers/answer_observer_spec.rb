require 'spec_helper'

describe AnswerObserver do
  before(:each) { AnswerObserver.instance }

  describe 'after answer posted' do
    it 'sends out an email to users who want to get forum notification' do
      User.make! :receive_forum_notifications => false
      question = Question.make!
      expect {
        Answer.make! :question => question
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end

