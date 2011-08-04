require 'spec_helper'

describe Answer do
  describe 'validation' do
    let(:answer) { Answer.make }

    it 'valid' do
      answer.should be_valid
    end

    it 'not valid if body is blank' do
      answer.body = nil
      answer.should_not be_valid
      answer.should have_at_least(1).error_on(:body)
    end

    it 'not valid if user is blank' do
      answer.user = nil
      answer.should_not be_valid
      answer.should have_at_least(1).error_on(:user)
    end

    it 'not valid if question is blank' do
      answer.question = nil
      answer.should_not be_valid
      answer.should have_at_least(1).error_on(:question)
    end
  end
end

