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
end

