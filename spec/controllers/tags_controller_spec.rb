require 'spec_helper'

describe TagsController do
  render_views
  def mock_tag(stubs={})
    @mock_tag ||= mock_model(DishTag, stubs).as_null_object
  end

  describe "GET #index" do
    it "success" do
      get :index
      response.should be_success
    end
  end

  describe "GET #new" do
    it "success" do
      get :new
      response.should be_success
    end

    it "assigns @tag" do
      get :new
      assigns(:tag).should be_an_instance_of(DishTag)
    end

    it "set @tag.value to nil (in order to render placeholder)" do
      get :new
      assigns(:tag).value.should be_nil
    end
  end

  describe "POST #create" do
    it "creates a new tag" do
      expect {
        post :create, :dish_tag => DishTag.make.attributes
      }.to change(DishTag, :count).by(1)
    end

    context "with valid tag" do
      before(:each) { DishTag.stub :new => mock_tag(:save => true) }

      it "redirects" do
        post :create
        response.should be_redirect
      end
    end

    context "with not valid tag" do
      before(:each) { DishTag.stub :new => mock_tag(:save => false) }

      it "redirects" do
        post :create
        response.should render_template('new')
      end
    end
  end
end

