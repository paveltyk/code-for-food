require 'spec_helper'

describe FeedbacksController do
  def mock_feedback(stubs={})
    @mock_feedback ||= mock_model(Feedback, stubs).as_null_object
  end

  describe 'when not logged in' do
    specify 'GET #new redirects to login path' do
      get :new
      response.should redirect_to login_path
    end

    specify 'POST #create redirects to login path' do
      post :create
      response.should redirect_to login_path
    end
  end

  describe 'when logged in' do
    before(:each) { controller.stub :current_user => user }
    let(:user) { User.make }

    describe 'GET #new' do
      it 'assigns @feedback' do
        get :new
        assigns(:feedback).should be_an_instance_of(Feedback)
      end
    end

    describe 'POST #create' do
      describe 'request' do
        it 'sends and email' do
          expect {
            post :create, :feedback => { :body => 'Hello' }
          }.to change(ActionMailer::Base.deliveries, :count).by(1)
        end
      end

      describe 'success story' do
        before(:each) do
          Feedback.stub :new => mock_feedback( :deliver => true )
          post :create
        end

        it 'sets flash notice' do
          flash[:notice].should_not be_blank
        end

        it 'redirects to action :new' do
          response.should redirect_to :action => :new
        end
      end

      describe 'fail story' do
        before(:each) do
          Feedback.stub :new => mock_feedback( :deliver => false )
          post :create
        end

        it 'renders template :new' do
          response.should render_template('new')
        end
      end
    end
  end
end

