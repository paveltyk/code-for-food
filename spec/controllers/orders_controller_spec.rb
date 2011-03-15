require 'spec_helper'

describe OrdersController do
  render_views
  setup :activate_authlogic

  def mock_order(stubs={})
    @mock_order ||= mock_model(Order, stubs).as_null_object
  end

  context "when logged in" do

    let(:menu) { Menu.make!(:with_3_dishes) }
    let(:user) { User.make! }
    let(:order) { Order.make! :user => user, :menu => menu }
    before(:each) { controller.stub :current_user => user }

    describe 'GET #show' do
      context 'when menu is published' do
        before(:each) { menu.publish! }

        it 'renders "show" template if menu is locked' do
          menu.update_attribute :locked, true
          order.reload
          get :show, :date => menu.to_param
          response.should render_template("show")
        end

        it 'renders "new" template if menu is not locked' do
          order.reload
          get :show, :date => menu.to_param
          response.should render_template("new")
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

      describe 'when menu is not published' do
        it 'renders "no_menu"' do
          get :show, :date => menu.to_param
          response.should render_template('no_menu')
        end

        it 'render "new" if logged in as admin' do
          controller.stub :current_user => menu.administrator
          get :show, :date => menu.to_param
          response.should render_template('new')
        end
      end

      it 'renders "no_menu" if menu not found' do
        Menu.stub_chain(:published, :find_by_date).and_return(nil)
        get :show, :date => '2011-11-11'
        response.should render_template('no_menu')
      end
    end

    describe 'POST #create' do
      let(:attrs) { { :dish_id => menu.dishes.last.id, :quantity => 1, :is_ordered => '1' } }

      context 'when menu is published' do
        before(:each) { menu.publish! }

        it "creates a new order" do
          expect {
            post :create, :date => menu.date.to_s(:db), :order => { :menu_items_attributes => { 0 => attrs } }
          }.to change(Order, :count).by(1)
        end

        context "success story" do
          before(:each) { controller.stub_chain(:current_user, :orders, :new).and_return(mock_order :save => true ) }

          it "redirects to action :show" do
            post :create, :date => menu.to_param
            response.should redirect_to(:action => :show)
          end
        end

        context "fail story" do
          before(:each) do
            user.stub_chain(:orders, :new).and_return(mock_order :save => false )
            user.stub_chain(:orders, :any?).and_return(false)
          end

          it "renders template \"new\"" do
            post :create, :date => menu.to_param
            response.should render_template("new")
          end
        end

        context 'when menu is blocked' do
          it 'redirects to :show with an error flash message' do
            menu.update_attribute :locked, true
            post :create, :date => menu.to_param
            response.should redirect_to(:action => :show)
            flash[:error].should_not be_blank
          end
        end
      end

     it 'renders "no_menu" if menu not found' do
        Menu.stub_chain(:published, :find_by_date).and_return(nil)
        post :create, :date => '2011-11-11'
        response.should render_template('no_menu')
      end

     it 'renders "no_menu" if menu not published' do
        post :create, :date => menu.to_param, :order => { :menu_items_attributes => { 0 => attrs } }
        response.should render_template('no_menu')
      end
    end

    describe 'PUT #update' do
      let(:attrs) { { :dish_id => order.menu.dishes.last.id, :quantity => 1, :is_ordered => '1'} }
      let(:order) do
        Order.make!(:user => user).tap do |order|
          Dish.make! :menu => order.menu
        end
      end
      before(:each) { menu.publish! }

      it "updates order with new data" do
        expect {
          put :update, :date => order.menu.to_param, :order => { :menu_items_attributes => { 0 => attrs } }
        }.to change(OrderItem, :count).by(1)
      end

      it 'redirects with an error flash message if menu is blocked' do
        order.menu.update_attribute :locked, true
        order.menu.publish!
        post :create, :date => order.menu.to_param
        response.should redirect_to(:action => :show)
        flash[:error].should_not be_blank
      end

      context 'fail story' do
        before(:each) do
          Menu.stub_chain(:published, :find_by_date).and_return(order.menu)
          user.stub_chain(:orders ,:find_by_menu_id).and_return(mock_order :update_attributes => false)
          user.stub_chain(:orders ,:any?).and_return(false)
        end

        it 'renders "new" template' do
          put :update, :date => menu.to_param
          response.should render_template('new')
        end
      end

      it 'renders "no_menu" if menu not found' do
        Menu.stub_chain(:published, :find_by_date).and_return(nil)
        put :update, :date => '2011-11-11'
        response.should render_template('no_menu')
      end
    end

    describe 'DELETE #destroy' do
      before(:each) do
        request.env['HTTP_REFERER'] = 'http://example.com'
        menu.publish!
      end

      it 'destroys an order' do
        order
        expect {
          delete :destroy, :date => order.menu.to_param
        }.to change(Order, :count).by(-1)
      end

      it 'redirects back' do
        delete :destroy, :date => order.menu.to_param
        response.should redirect_to(:back)
      end

      it 'sets a flash notice' do
        delete :destroy, :date => order.menu.to_param
        flash[:notice].should_not be_blank
      end

      it 'does not destroy an order if it is locked' do
        menu.update_attribute :locked, true
        order
        expect {
            delete :destroy, :date => order.menu.to_param
          }.to_not change(Order, :count)
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

    describe 'DELETE #destroy' do
      it 'redirects to login' do
        put :destroy, :date => '2001-01-01'
        response.should redirect_to(login_path)
      end
    end
  end
end

