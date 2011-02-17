require 'spec_helper'

describe InvitationsController do
  render_views
  setup :activate_authlogic

  def mock_invitation(stubs={})
    @mock_invitation ||= mock_model(Invitation, stubs).as_null_object
  end

  context "when not logged in" do
    {:new => :get, :create => :post}.each do |action, method|
      it "redirect when #{method.to_s.upcase} #{action}" do
        send method, action
        response.should redirect_to(login_url)
      end
    end
  end

  context "when logged in" do
    let(:current_user) { User.make! }
    before(:each) { controller.stub(:current_user => current_user) }

    describe "GET new" do
      it "assigns a new invitation as @invitation" do
        get :new
        assigns(:invitation).should be_an_instance_of(Invitation)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates an invitation" do
          expect {
            post :create, :invitation => Invitation.make.attributes
          }.to change(Invitation, :count).by(1)
        end

        it "redirects to the created invitation" do
          current_user.stub_chain(:sent_invitations, :build) { mock_invitation(:save => true) }
          post :create, :invitation => {}
          response.should redirect_to(new_invitation_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved invitation as @invitation" do
          current_user.stub_chain(:sent_invitations, :build).with({'these' => 'params'}) { mock_invitation(:save => false) }
          post :create, :invitation => {'these' => 'params'}
          assigns(:invitation).should be(mock_invitation)
        end

        it "re-renders the 'new' template" do
          current_user.stub_chain(:sent_invitations, :build) { mock_invitation(:save => false) }
          post :create, :invitation => {}
          response.should render_template("new")
        end
      end
    end
  end
end

