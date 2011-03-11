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

      it 'renders "no_menu" if menu not found' do
        Menu.stub :find_by_date => nil
        get :show, :date => '2011-11-11'
        response.should render_template('no_menu')
      end
    end

    describe 'GET #new' do
      context 'when menu not blocked' do
        before(:each) { get :new, :date => menu.to_param }

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

      context 'when menu is blocked' do
        it 'redirects with an error flash message' do
          order.menu.update_attribute :locked, true
          get :new, :date => order.menu.to_param
          response.should redirect_to(:action => :show)
          flash[:error].should_not be_blank
        end
      end

      it 'renders "no_menu" if menu not found' do
        Menu.stub :find_by_date => nil
        get :new, :date => '2011-11-11'
        response.should render_template('no_menu')
      end
    end

    describe 'POST #create' do
      let(:attrs_for_first_dish) { { :dish_id => menu.dishes.first.id, :quantity => 1, :is_ordered => '1'} }

      it "creates a new order" do
        expect {
          post :create, :date => menu.date.to_s(:db), :order => { :menu_items_attributes => { 0 => attrs_for_first_dish } }
        }.to change(Order, :count).by(1)
      end

      it 'renders "no_menu" if menu not found' do
        Menu.stub :find_by_date => nil
        post :create, :date => '2011-11-11'
        response.should render_template('no_menu')
      end

      context "with valid order" do
        before(:each) { controller.stub_chain(:current_user, :orders, :new).and_return(mock_model(Order, :save => true).as_null_object) }

        it "redirects to action :new" do
          post :create, :date => menu.date.to_s(:db)
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

      context 'when menu is blocked' do
        it 'redirects with an error flash message' do
          menu.update_attribute :locked, true
          post :create, :date => menu.to_param
          response.should redirect_to(:action => :show)
          flash[:error].should_not be_blank
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

      it 'renders "no_menu" if menu not found' do
        Menu.stub :find_by_date => nil
        put :update, :date => '2011-11-11'
        response.should render_template('no_menu')
      end

      context 'fail story' do
        before(:each) do
          controller.stub :current_user => logged_in_user
          logged_in_user.stub_chain(:orders ,:find_by_menu_id).and_return(mock_model(Order, :update_attributes => false).as_null_object)
        end

        it 'renders "new" template' do
          put :update, :date => menu.to_param
          response.should render_template('new')
        end
      end

      context 'when menu is blocked' do
        it 'redirects with an error flash message' do
          order.menu.update_attribute :locked, true
          post :create, :date => order.menu.to_param
          response.should redirect_to(:action => :show)
          flash[:error].should_not be_blank
        end
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

