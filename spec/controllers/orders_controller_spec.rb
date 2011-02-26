require 'spec_helper'

describe OrdersController do
  render_views
  setup :activate_authlogic

  context "when logged in" do

    let(:menu) { Menu.make!(:with_3_dishes) }
    let(:logged_in_user) { User.make! }
    before(:each) { UserSession.create logged_in_user }

    describe "#new" do
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

    describe "#create" do
      let(:attrs_for_first_dish) { { :dish_id => menu.dishes.first.id, :quantity => 1, :is_ordered => '1'} }

      it "creates a new order" do
        expect {
          post :create, :date => menu.date.to_s(:db), :order => { :menu_items_attributes => { "0" => attrs_for_first_dish } }
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
  end
end

