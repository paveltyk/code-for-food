require 'spec_helper'

describe SessionsController do
  render_views
  setup :activate_authlogic

  describe "GET new" do
    it "assigns a new UserSession as @user_session" do
      get :new
      assigns(:user_session).should be_an_instance_of(UserSession)
    end
  end

  describe "POST create" do
    let(:user) { User.make! }

    it "login valid user" do
      post :create, :user_session => { :email => user.email, :password => user.password }
      user.reload.persistence_token.should eql(controller.session['user_credentials'])
    end

    it "renders \"new\" template if credentials not valid" do
      post :create, :user_session => { :email => 'not valid', :password => user.password }
      response.should render_template('new')
    end
  end
end

