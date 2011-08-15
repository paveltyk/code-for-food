require 'spec_helper'

describe AnswerObserver do
  before(:each) { AnswerObserver.instance }

  describe 'after answer posted' do
    it 'sends out an email' do
      question = Question.make!
      expect {
        Answer.make! :question => question
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end

