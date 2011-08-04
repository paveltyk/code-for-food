require 'spec_helper'

describe QuestionsController do
  render_views
  setup :activate_authlogic

  describe 'when logged in' do
    let(:user) { User.make! }
    before(:each) { controller.stub :current_user => user }

    describe 'GET #index' do
      it 'successes when there is no questions' do
        get :index
        response.should be_success
      end

      it 'assigns 10 questions' do
        Question.destroy_all
        10.times { Question.make! }
        get :index
        assigns(:questions).should have(10).items
      end
    end

    describe 'GET #new' do
      it 'success' do
        get :new
        response.should be_success
      end
    end

    describe 'POST #create' do
      def mock_question(stubs={})
        @mock_question ||= mock_model(Question, stubs).as_null_object
      end

      it 'redirects to questions_path if question is valid' do
        Question.should_receive(:new).once.and_return mock_question(:save => true)
        post :create
        response.should redirect_to(questions_path)
      end

      it 'renders :new template if question is invalid' do
        Question.should_receive(:new).once.and_return mock_question(:save => false, :persisted? => false)
        post :create
        response.should render_template(:new)
      end

      it 'assigns user to question' do
        Question.should_receive(:new).once.and_return mock_question(:save => true)
        mock_question.should_receive(:'user=').once
        post :create
      end
    end
  end
end

