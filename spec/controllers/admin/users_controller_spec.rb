require 'spec_helper'

describe Admin::UsersController do
  render_views
  setup :activate_authlogic
  let(:admin) { Administrator.make! }
  before(:each) { UserSession.create admin }

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
end

