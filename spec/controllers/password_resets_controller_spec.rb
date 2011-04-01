require 'spec_helper'

describe PasswordResetsController do
  describe '#new' do
    it 'renders 200' do
      get :new
      response.should be_success
    end

    it 'assigns email from params' do
      get :new, :email => 'admin@email.com'
      assigns(:email).should eq 'admin@email.com'
    end
  end

  describe '#create' do
    describe 'success_story' do
      let(:user) { User.make! }
      before(:each) { User.stub :find_by_email => user }

      it 'redirects to root path' do
        post :create
        response.should redirect_to root_path
      end

      it 'assigns flash notice' do
        post :create
        flash[:notice].should =~ /успешно/i
      end

      it 'resets perishable token' do
        user.should_receive(:reset_perishable_token!).once
        post :create
      end
    end

    describe 'fail story' do
      before(:each) { User.stub :find_by_email => nil }

      it 'assigns flash error' do
        post :create
        flash[:error].should =~ /Не удалось/i
      end

      it 'renders "new" template' do
        post :create
        response.should render_template('new')
      end
    end
  end
end

