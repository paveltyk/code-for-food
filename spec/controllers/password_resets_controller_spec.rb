require 'spec_helper'

describe PasswordResetsController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

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
        response.should redirect_to new_password_reset_path
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

  describe '#edit' do
    describe 'success story' do
      before(:each) do
        User.stub(:find_using_perishable_token).with('1').and_return(mock_user)
        get :edit, :id => '1'
      end

      it 'assigns @user' do
        assigns(:user).should_not be_nil
      end

      it 'renders "edit" template' do
        response.should render_template("edit")
      end
    end

    describe 'fail story' do
      before(:each) do
        User.stub(:find_using_perishable_token).and_return(nil)
        get :edit, :id => '1'
      end

      it 'assigns flash message' do
        flash[:error].should =~ /Не удалось/i
      end

      it 'redirects to root path' do
        response.should redirect_to(new_password_reset_path)
      end
    end
  end

  describe '#update' do
    describe 'success story' do
      before(:each) do
        mock_user.stub :save => true
        User.stub(:find_using_perishable_token).with('1').and_return(mock_user)
        put :update, :id => '1'
      end

      it 'sets flash message' do
        flash[:notice].should =~ /упешно/i
      end

      it 'redirects to root path' do
        response.should redirect_to root_path
      end
    end

    describe 'fail story' do
      before(:each) do
        mock_user.stub :save => false
        User.stub(:find_using_perishable_token).with('1').and_return(mock_user)
        put :update, :id => '1'
      end

      it 'renders "edit" template' do
        response.should render_template("edit")
      end
    end
  end
end

