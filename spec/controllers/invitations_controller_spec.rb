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

    it "redirect when PUT resend" do
      put :resend, :id => '1'
      response.should redirect_to(login_url)
    end
  end

  context "when logged in as admin" do
    let(:admin) { Administrator.make! }
    before(:each) { UserSession.create(admin) }

    describe "GET new" do
      it "assigns a new invitation as @invitation" do
        get :new
        assigns(:invitation).should be_an_instance_of(Invitation)
      end

      it "assigns a sent invitations as @invitations" do
        Invitation.stub_chain(:includes, :all) { [] }
        get :new
        assigns(:invitations).should eq []
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates an invitation" do
          expect {
            post :create, :invitation => Invitation.make.attributes
          }.to change(Invitation, :count).by(1)
        end

        it "redirects to the :new action" do
          post :create, :invitation => Invitation.make.attributes
          response.should redirect_to(new_invitation_url)
        end

        it "sets flash notice with an recipients email" do
          invitation = Invitation.make
          post :create, :invitation => invitation.attributes
          flash[:notice].should match invitation.recipient_email
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved invitation as @invitation" do
          post :create, :invitation => {}
          assigns(:invitation).should be_a_new_record
        end

        it "re-renders the 'new' template" do
          admin.stub_chain(:sent_invitations, :build).and_return(mock_invitation :save => false)
          post :create, :invitation => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT #resend" do
      describe "success story" do
        before(:each) do
          Invitation.stub(:find) { mock_invitation }
          Mailer.stub_chain(:invitation, :deliver).and_return(true)
          Mailer.should_receive(:invitation).with(mock_invitation)
          put :resend, :id => '1'
        end

        it "sets flash notice" do
          flash[:notice].should_not be_blank
        end

        it "redirects to action :new" do
          response.should redirect_to :action => :new
        end
      end

      describe "fail story" do
        before(:each) do
          Invitation.stub(:find) { mock_invitation }
          Mailer.stub_chain(:invitation, :deliver).and_return(false)
          Mailer.should_receive(:invitation).with(mock_invitation)
          put :resend, :id => '1'
        end

        it "sets flash error" do
          flash[:error].should_not be_blank
        end

        it "redirects to action :new" do
          response.should redirect_to :action => :new
        end
      end
    end
  end
end

