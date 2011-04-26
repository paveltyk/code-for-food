require 'spec_helper'

describe BalanceController do
  context 'when not logged in' do
    describe 'GET #show' do
      it 'redirects to login page' do
        get :show
        response.should redirect_to(login_path)
      end
    end
  end

  describe 'when logged in' do
    before(:each) { controller.stub :current_user => user }
    let(:user) { User.make }

    describe 'GET #show' do
      it 'assigns correct instance variables' do
        user.stub_chain(:payment_transactions, :total).and_return(10)
        user.stub_chain(:orders, :total).and_return(7)
        get :show
        assigns(:transactions_total).should == 10
        assigns(:orders_total).should == 7
        assigns(:balance).should == 3
      end
    end
  end
end

