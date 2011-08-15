require 'spec_helper'

describe Question do
  describe 'validation:' do
    let(:question) { Question.make }

    it 'valid' do
      question.should be_valid
    end

    it 'not valid if :question_id present' do
      question.question_id = 1
      question.should_not be_valid
      question.should have_at_least(1).error_on(:question_id)
    end

    it 'not valid if :body is blank' do
      question.body = nil
      question.should_not be_valid
      question.should have_at_least(1).error_on(:body)
    end

    it 'not valid if :user is blank' do
      question.user = nil
      question.should_not be_valid
      question.should have_at_least(1).error_on(:user)
    end
  end
end

