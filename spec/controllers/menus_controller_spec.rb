require 'spec_helper'

describe MenusController do
  render_views

  it "renders a new menu page" do
    get :new
    response.should render_template('new')
  end

  it "creates a new menu" do
    expect { post :create, :menu => Menu.make.attributes }.to change(Menu, :count).from(0).to(1)
  end

  it "creates the dishes for menu" do
    post_attrs = Menu.make.attributes.merge :dishes_attributes => {0 => Dish.make(:menu => nil).attributes, 1 => Dish.make(:menu => nil).attributes}
    expect { post :create, :menu => post_attrs }.to change(Dish, :count).from(0).to(2)
  end

  it "redirects to \"show\" action" do
    post :create, :menu => Menu.make.attributes
    response.should be_redirect
  end

  it "renders a \"new\" template if menu not valid" do
    post :create
    response.should render_template('new')
  end

  it "assigns menu and renders a \"show\" template" do
    menu = Menu.make!
    2.times { Dish.make! :menu => menu }
    get :show, :id => menu.id
    assigns[:menu].should eql(menu)
    response.should render_template('show')
  end
end

