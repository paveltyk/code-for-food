require 'spec_helper'

describe Admin::OrdersController do
  before(:each) { controller.stub :current_user => Administrator.make }

  def mock_order(stubs={})
    @mock_order ||= mock_model(Order, stubs).as_null_object
  end

  describe 'GET #show' do
    it 'assigns @order' do
      Order.stub(:find) { mock_order }
      get :show, :id => '1'
      assigns(:order).should eq mock_order
    end
  end

  describe 'GET #edit' do
    it 'assigns @order' do
      Order.stub(:find) { mock_order }
      get :edit, :id => '1'
      assigns(:order).should eq mock_order
    end
  end

  describe 'PUT #update' do

    it 'change order owner' do
      order = Order.make!
      new_owner = User.make!
      put :update, :id => order.to_param, :order => { :user_id => new_owner.id }
      order.reload.user.should eq new_owner
    end

    describe 'success story' do
      let(:order) { mock_order :update_attributes => true }
      before(:each) do
        Order.stub :find => order
        put :update, :id => 1
      end

      it 'redirects to action :show' do
        response.should redirect_to [:admin, order]
      end

      it 'sets flash notice' do
        flash[:notice].should_not be_blank
      end
    end

    describe 'fail story' do
      let(:order) { mock_order :update_attributes => false }
      before(:each) do
        Order.stub :find => order
        put :update, :id => 1
      end

      it 'redirects to action :show' do
        response.should render_template('edit')
      end
    end
  end

  describe 'delete #destroy' do
    it 'destroys the order' do
      order = Order.make!
      expect {
        delete :destroy, :id => order.to_param
      }.to change(Order, :count).by(-1)
    end

    it 'redirects to UsersController#show' do
      Order.stub :find => mock_order( :destroy => true, :user => User.make! )
      delete :destroy, :id => '1'
      response.should redirect_to admin_user_path(mock_order.user)
    end

  end
end

