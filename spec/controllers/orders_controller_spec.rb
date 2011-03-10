require 'spec_helper'

describe OrdersController do
  render_views
  setup :activate_authlogic

  context "when logged in" do

    let(:menu) { Menu.make!(:with_3_dishes) }
    let(:logged_in_user) { User.make! }
    let(:order) { Order.make! :user => logged_in_user, :menu => menu }
    before(:each) { UserSession.create logged_in_user }

    describe 'GET #show' do
      it 'renders "show" template' do
        order.reload
        get :show, :date => menu.to_param
        response.should render_template("show")
      end

      it 'assigns @order' do
        order.reload
        get :show, :date => menu.to_param
        assigns(:order).should eql order
      end

      it 'assigns new order if no order found for that date' do
        get :show, :date => menu.to_param
        assigns(:order).should be_a_new_record
      end
    end

    describe 'GET #new' do
      before(:each) { get :new, :date => menu.date.to_s(:db) }

      it "responds with 200" do
        response.should be_success
      end

      it "assigns menu" do
        assigns(:menu).should eql(menu)
      end

      it "assigns order" do
        assigns(:order).should be_an_instance_of(Order)
      end
    end

    describe 'POST #create' do
      let(:attrs_for_first_dish) { { :dish_id => menu.dishes.first.id, :quantity => 1, :is_ordered => '1'} }

      it "creates a new order" do
        expect {
          post :create, :date => menu.date.to_s(:db), :order => { :menu_items_attributes => { 0 => attrs_for_first_dish } }
        }.to change(Order, :count).by(1)
      end

      context "with valid order" do
        before(:each) { controller.stub_chain(:current_user, :orders, :new).and_return(mock_model(Order, :save => true).as_null_object) }

        it "redirects to action :new" do
          post :create, :date => menu.date.to_s(:db), :order => {}
          response.should redirect_to(:action => :new)
        end
      end

      context "with invalid order" do
        before(:each) { controller.stub_chain(:current_user, :orders, :new).and_return(mock_model(Order, :save => false).as_null_object) }

        it "renders template \"new\"" do
          post :create, :date => menu.date.to_s(:db)
          response.should render_template("new")
        end
      end
    end

    describe 'PUT #update' do
      let(:attrs_for_first_dish) { { :dish_id => order.menu.dishes.first.id, :quantity => 1, :is_ordered => '1'} }
      let(:order) do
        Order.make!(:user => logged_in_user).tap do |order|
          2.times { order.menu.dishes << Dish.make! }
        end
      end

      it "updates order with new data" do
        expect {
          put :update, :date => order.menu.date.to_s(:db), :order => { :menu_items_attributes => { 0 => attrs_for_first_dish } }
        }.to change(order.order_items, :count).by(1)
      end
    end
  end

  context "when not logged in" do
    describe 'GET #show' do
      it 'redirects to login' do
        get :show, :date => '2001-01-01'
        response.should redirect_to(login_path)
      end
    end

    describe 'GET #new' do
      it 'redirects to login' do
        get :new, :date => '2001-01-01'
        response.should redirect_to(login_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login' do
        post :create, :date => '2001-01-01'
        response.should redirect_to(login_path)
      end
    end

    describe 'PUT #update' do
      it 'redirects to login' do
        put :update, :date => '2001-01-01'
        response.should redirect_to(login_path)
      end
    end
  end
end

