require 'spec_helper'

describe Admin::MenusController do
  render_views
  setup :activate_authlogic

  def mock_menu(stubs = {})
    @mock_menu ||= mock_model(Menu, stubs).as_null_object
  end

  describe "GET new" do
    context "when not logged in" do
      it "redirects to login page" do
        get :new
        response.should redirect_to(login_path)
      end
    end

    context "when logged in as admin" do
      let(:admin) { Administrator.make! }
      before(:each) { UserSession.create(admin) }

      it "renders a \"new\" template" do
        get :new
        response.should render_template('new')
      end

      it "sets a menu date from params" do
        get :new, :date => '1999-03-05'
        assigns[:menu].date.should eql(Date.parse('1999-03-05'))
      end
    end
  end

  describe "POST create" do
    context "when not logged in" do
      it "redirects to login page" do
        post :create, :menu => Menu.make.attributes
        response.should redirect_to(login_path)
      end
    end

    context "when logged in as admin" do
      before(:each) {UserSession.create(Administrator.make!)}

      it "creates a new menu" do
        expect { post :create, :menu => Menu.make.attributes }.to change(Menu, :count).by(1)
      end

      it "creates the dishes for menu" do
        post_attrs = Menu.make.attributes.merge :dishes_attributes => {0 => Dish.make(:menu => nil).attributes, 1 => Dish.make(:menu => nil).attributes}
        expect { post :create, :menu => post_attrs }.to change(Dish, :count).by(2)
      end

      it "redirects to \"order\" path" do
        post :create, :menu => Menu.make.attributes
        response.should redirect_to order_path(Menu.last)
      end

      it "renders a \"new\" template if menu not valid" do
        post :create
        assigns[:menu].should_not be_valid
        response.should render_template('new')
      end
    end
  end

  describe "GET show" do
    context "when not logged in" do
      it "redirects to login page" do
        post :create, :menu => Menu.make.attributes
        response.should redirect_to(login_path)
      end
    end

    context "when logged in as regular user" do
      it "redirects to login page" do
        UserSession.create(User.make!)
        post :create, :menu => Menu.make.attributes
        response.should redirect_to(login_path)
      end
    end

    context "when logged in as admin" do
      let(:admin) { Administrator.make! }
      before(:each) { UserSession.create(admin) }

      it "assigns menu and renders a \"show\" template" do
        menu = Menu.make!(:administrator => admin)
        2.times { Dish.make! :menu => menu }
        get :show, :id => menu.to_param
        assigns(:menu).should eql(menu)
        response.should render_template('show')
      end

      it 'assigns @orders' do
        menu = Menu.make!(:administrator => admin)
        get :show, :id => menu.to_param
        assigns(:orders).should be_an_instance_of(ActiveRecord::Relation)
      end

      it 'assigns @total_price' do
        menu = Menu.make!(:administrator => admin)
        3.times { Order.make! :menu => menu }
        get :show, :id => menu.to_param
        assigns(:total_price).should_not be_nil
      end

      it 'assgins orders ordered by user name' do
        menu = Menu.make!(:administrator => admin)
        3.times { |i| Order.make! :menu => menu, :user => User.make!(:name => 3-i) }
        get :show, :id => menu.to_param
        assigns(:orders).map { |order| order.user.name }.should eq %w{1 2 3}
      end
    end
  end

  describe "GET edit" do
    context "when not logged in" do
      it "redirects to login page" do
        post :create, :menu => Menu.make.attributes
        response.should redirect_to(login_path)
      end
    end

    context "when logged in as admin" do
      let(:admin) { Administrator.make! }
      before(:each) { UserSession.create(admin) }

      it "assigns the menu and renders the \"edit\" page" do
        menu = Menu.make!(:administrator => admin)
        get :edit, :id => menu.to_param
        response.should render_template('new')
        assigns[:menu].should eql(menu)
      end
    end
  end

  describe "PUT update" do
    context "when not logged in" do
      it "redirects to login page" do
        put :update, :id => 1, :menu => {}
        response.should redirect_to(login_path)
      end
    end

    context "when logged in as admin" do
      let(:admin) { Administrator.make! }
      let(:menu) { Menu.make!(:administrator => admin) }
      let(:dish) { Dish.make!(:menu => menu) }
      before(:each) { Menu.destroy_all; UserSession.create(admin) }

      context "with valid menu attrs" do
        before :each do
          put :update, :id => menu.to_param, :menu => { :date => '1999-10-01' }
        end

        it "updates the date of the menu" do
          assigns[:menu].should be_valid
          assigns[:menu].date.should eql(Time.parse('1999-10-01').to_date)
        end

        it "redirects to \"order\" path" do
          response.should redirect_to order_path(menu.reload)
        end

        it "set the success flash message" do
          flash[:notice].should_not be_blank
        end
      end

      context "nested dishes" do
        it "changes dish name" do
          put :update, :id => dish.menu.to_param, :menu => {:dishes_attributes => {0 => {:id => dish.id, :name => 'Awesome stake'}}}
          assigns[:menu].dishes.first.name.should eql('Awesome stake')
        end

        it "destroys a dish" do
          put :update, :id => dish.menu.to_param, :menu => {:dishes_attributes => {0 => {:id => dish.id, :_destroy => 1}}}
          assigns[:menu].reload.should have(0).dishes
        end

        it "renders the \"new\" template if any of the dishes is not valid" do
          put :update, :id => dish.menu.to_param, :menu => {:dishes_attributes => {0 => {:id => dish.id, :price => 1}}}
          response.should render_template('new')
        end
      end

      context "with invalid menu attrs" do
        before :each do
          put :update, :id => menu.to_param, :menu => {:dishes_attributes => {0 => {:id => dish.id, :price => -1}}}
        end

        it "renders the \"new\" template" do
          response.should render_template('new')
        end
      end
    end
  end

  describe 'PUT #lock' do
    context 'when not logged in' do
      it 'redirects to login' do
        put :lock, :id => 1
        response.should redirect_to(login_path)
      end
    end

    context 'when logged in as regular user' do
      it 'redirects to login' do
        UserSession.create User.make!
        put :lock, :id => 1
        response.should redirect_to(login_path)
      end
    end

    context 'when logged in as admin' do
      let(:menu) { Menu.make! }
      let(:admin) { menu.administrator }

      before(:each) do
        controller.stub :current_user => admin
        request.env["HTTP_REFERER"] = 'http://example.com'
      end

      it 'locks the menu' do
        put :lock, :id => menu.to_param
        menu.reload.locked.should be_true
      end

      context 'success story' do
        before(:each) { admin.stub_chain(:menus, :find_by_date).and_return(mock_menu :update_attribute => true) }

        it 'set flash notice' do
          put :lock, :id => 1
          flash[:notice].should_not be_blank
        end

        it 'redirects back' do
          put :lock, :id => 1
          response.should redirect_to(:back)
        end
      end

      context 'fail story' do
        before(:each) { admin.stub_chain(:menus, :find_by_date).and_return(mock_menu :update_attribute => false) }

        it 'set flash error' do
          put :lock, :id => 1
          flash[:error].should_not be_blank
        end

        it 'redirects back' do
          put :lock, :id => 1
          response.should redirect_to(:back)
        end
      end
    end
  end

  describe 'PUT #publish' do
    context 'when not logged in' do
      it 'redirects to login' do
        put :publish, :id => 1
        response.should redirect_to(login_path)
      end
    end

    context 'when logged in as regular user' do
      it 'redirects to login' do
        UserSession.create User.make!
        put :publish, :id => 1
        response.should redirect_to(login_path)
      end
    end

    context 'when logged in as admin' do
      let(:menu) { Menu.make! }
      let(:admin) { menu.administrator }

      before(:each) do
        controller.stub :current_user => admin
        request.env["HTTP_REFERER"] = 'http://example.com'
      end

      it 'publishes the menu' do
        put :publish, :id => menu.to_param
        menu.reload.should be_published
      end

      it 'sends an email' do
        expect {
          put :publish, :id => menu.to_param
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end

      context 'success story' do
        before(:each) { admin.stub_chain(:menus, :find_by_date).and_return(mock_menu :publish! => true) }

        it 'set flash notice' do
          put :publish, :id => 1
          flash[:notice].should_not be_blank
        end

        it 'redirects back' do
          put :publish, :id => 1
          response.should redirect_to(:back)
        end
      end

      context 'fail story' do
        before(:each) { admin.stub_chain(:menus, :find_by_date).and_return(mock_menu :publish! => false) }

        it 'set flash error' do
          put :publish, :id => 1
          flash[:error].should_not be_blank
        end

       it 'redirects back' do
          put :publish, :id => 1
          response.should redirect_to(:back)
        end
      end
    end
  end
end

