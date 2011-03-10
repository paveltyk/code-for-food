require 'spec_helper'

describe ReportsController do
  render_views

  describe 'GET #provider' do
    context 'when logged in as admin' do
      let(:menu) { Menu.make! }
      let(:admin) { menu.administrator }
      before(:each) { controller.stub :current_user => admin }

      it 'success' do
        get :provider, :id => menu.to_param
        response.should be_success
      end

      it 'assigns @menu and @report' do
        get :provider, :id => menu.to_param
        assigns(:menu).should eql menu
        assigns(:report).should be_an_instance_of(::Report::ProviderReport)
      end
    end
  end
end

