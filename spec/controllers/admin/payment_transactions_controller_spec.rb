require 'spec_helper'

describe Admin::PaymentTransactionsController do
  before(:each) do
    controller.stub :require_admin => nil
    User.stub :find => mock_user
  end

  def mock_transaction(stubs={})
    @mock_ransaction ||= mock_model(PaymentTransaction, stubs).as_null_object
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET #index" do
    it "assigns all user payment_transactions as @payment_transactions" do
      mock_user.stub_chain(:payment_transactions, :all) { [mock_transaction] }
      get :index, :user_id => 0
      assigns(:payment_transactions).should eq([mock_transaction])
    end

    it 'renders "index" template' do
      get :index, :user_id => 0
      response.should render_template("index")
    end
  end

  describe "GET #new" do
    it "assigns a new payment_transaction as @payment_transaction" do
      mock_user.stub_chain(:payment_transactions, :build) { mock_transaction }
      get :new, :user_id => 0
      assigns(:payment_transaction).should be(mock_transaction)
    end

    it 'renders "new" template' do
      get :new, :user_id => 0
      response.should render_template("new")
    end
  end

  describe "GET #edit" do
    it "assigns the requested payment_transaction as @payment_transaction" do
      mock_user.stub_chain(:payment_transactions, :find).with(0) { mock_transaction }
      get :edit, :id => 0, :user_id => 0
      assigns(:payment_transaction).should be(mock_transaction)
    end

    it 'renders "edit" template' do
      get :edit, :id => 0, :user_id => 0
      response.should render_template("edit")
    end
  end

  describe "POST #create" do
    describe "with valid params" do
      it "assigns a newly created payment_transaction as @payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :build).with({'these' => 'params'}) { mock_transaction(:save => true) }
        post :create, :payment_transaction => {'these' => 'params'}, :user_id => 0
        assigns(:payment_transaction).should be(mock_transaction)
      end

      it "redirects to the created payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :build) { mock_transaction(:save => true) }
        post :create, :payment_transaction => {}, :user_id => 0
        response.should redirect_to(:action => :index)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved payment_transaction as @payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :build).with({'these' => 'params'}) { mock_transaction(:save => false) }
        post :create, :payment_transaction => {'these' => 'params'}, :user_id => 0
        assigns(:payment_transaction).should be(mock_transaction)
      end

      it "re-renders the 'new' template" do
        mock_user.stub_chain(:payment_transactions, :build) { mock_transaction(:save => false) }
        post :create, :payment_transaction => {}, :user_id => 0
        response.should render_template("new")
      end
    end
  end

  describe "PUT #update" do
    describe "with valid params" do
      it "updates the requested payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :find).with(0) { mock_transaction }
        mock_transaction.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => 0, :payment_transaction => {'these' => 'params'}, :user_id => 0
      end

      it "assigns the requested payment_transaction as @payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :find) { mock_transaction(:update_attributes => true) }
        put :update, :id => 0, :user_id => 0
        assigns(:payment_transaction).should be(mock_transaction)
      end

      it "redirects to the payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :find) { mock_transaction(:update_attributes => true) }
        put :update, :id => "1", :user_id => 0
        response.should redirect_to(:action => :index)
      end
    end

    describe "with invalid params" do
      it "assigns the payment_transaction as @payment_transaction" do
        mock_user.stub_chain(:payment_transactions, :find) { mock_transaction(:update_attributes => false) }
        put :update, :id => 0, :user_id => 0
        assigns(:payment_transaction).should be(mock_transaction)
      end

      it "re-renders the 'edit' template" do
        mock_user.stub_chain(:payment_transactions, :find) { mock_transaction(:update_attributes => false) }
        put :update, :id => 0, :user_id => 0
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested payment_transaction" do
      mock_user.stub_chain(:payment_transactions, :find).with(0) { mock_transaction }
      mock_transaction.should_receive(:destroy)
      delete :destroy, :id => 0, :user_id => 0
    end

    it "redirects to the payment_transactions list" do
      mock_user.stub_chain(:payment_transactions, :find) { mock_transaction }
      delete :destroy, :id => 0, :user_id => 0
      response.should redirect_to(:action => :index)
    end
  end

end

