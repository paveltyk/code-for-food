require 'spec_helper'

describe Admin::UsersController do
  render_views
  setup :activate_authlogic
  let(:admin) { Administrator.make! }
  before(:each) { UserSession.create admin }

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe 'GET #index' do
    it 'renders "index" template' do
      get :index
      response.should render_template('index')
    end

    it 'assigns @users' do
      get :index
      assigns(:users).should_not be_nil
    end
  end

  describe 'GET #show' do
    let(:user) { User.make! }

    it 'renders "show" template' do
      get :show, :id => user.to_param
      response.should render_template('show')
    end

    it 'assigns @user' do
      User.stub :find => mock_user
      get :show, :id => '1'
      assigns(:user).should eql mock_user
    end

    it 'assigns @orders' do
      mock_user.stub_chain(:orders, :joins, :includes, :order).and_return([])
      mock_user.stub_chain(:orders, :total).and_return(0)
      User.stub :find => mock_user
      get :show, :id => '1'
      assigns(:orders).should eql []
    end
  end
end

