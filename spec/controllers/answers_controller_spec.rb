require 'spec_helper'

describe AnswersController do
  render_views
  setup :activate_authlogic

  describe 'when logged in' do
    let(:user) { User.make! }
    before(:each) { controller.stub :current_user => user }

    describe 'GET #new' do
      it 'success' do
        question = Question.make!
        Question.should_receive(:find).with('1').once.and_return question
        get :new, :question_id => '1'
        response.should be_success
      end
    end

    describe 'POST #create' do
      def mock_answer(stubs={})
        @mock_answer ||= mock_model(Answer, stubs).as_null_object
      end

      it 'redirects to questions_path if answer is valid' do
        question = Question.make!
        question.stub_chain(:answers, :new).and_return mock_answer(:save => true)
        Question.should_receive(:find).once.and_return question
        post :create, :question_id => '1'
        response.should redirect_to(questions_path)
      end

      it 'renders :new template if question is invalid' do
        question = Question.make!
        question.stub_chain(:answers, :new).and_return mock_answer(:save => false, :persisted? => false)
        Question.should_receive(:find).once.and_return question
        post :create, :question_id => '1'
        response.should render_template(:new)
      end
    end
  end
end

