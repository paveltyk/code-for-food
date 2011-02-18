require 'spec_helper'

describe UsersController do
  render_views
  setup :activate_authlogic

  describe "GET 'new'" do
    it "successful" do
      get :new, :invitation_token => 1
      response.should be_success
    end
  end

  describe "POST create" do
    let(:invitation) { Invitation.make! }
    let(:valid_attrs) do
      Hash.new.tap do |attrs|
        user = User.make
        attrs[:email] = user.email
        attrs[:password] = attrs[:password_confirmation] = user.password
        attrs[:invitation_token] = invitation.token
      end
    end

    it "creates a new user" do
      attrs = valid_attrs
      expect {
        post :create, :user => attrs
      }.to change(User, :count).by(1)
    end

    it "redirects" do
      post :create, :user => valid_attrs
      response.should be_redirect
    end

    it "renders \"new\" template if not valid user params passed" do
      post :create, :user => valid_attrs.merge(:email => nil)
      response.should render_template('new')
    end

    it "renders \"new\" template if invitation_token does not exists" do
      post :create, :user => valid_attrs.merge(:invitation_token => 'hello')
      response.should render_template('new')
    end
  end
end
