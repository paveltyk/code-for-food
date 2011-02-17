require 'spec_helper'

describe InvitationsController do
  render_views
  def mock_invitation(stubs={})
    @mock_invitation ||= mock_model(Invitation, stubs).as_null_object
  end

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
        Invitation.stub(:new) { mock_invitation(:save => true) }
        post :create, :invitation => {}
        response.should redirect_to(new_invitation_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved invitation as @invitation" do
        Invitation.stub(:new).with({'these' => 'params'}) { mock_invitation(:save => false) }
        post :create, :invitation => {'these' => 'params'}
        assigns(:invitation).should be(mock_invitation)
      end

      it "re-renders the 'new' template" do
        Invitation.stub(:new) { mock_invitation(:save => false) }
        post :create, :invitation => {}
        response.should render_template("new")
      end
    end
  end
end

