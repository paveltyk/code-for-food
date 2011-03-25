require 'spec_helper'

describe Admin::ReportsController do
  describe 'routing' do
    it 'recognizes and generates #provider' do
      { :get => '/admin/menus/2011-11-11/reports/provider' }.should route_to(:controller => 'admin/reports', :action => 'provider', :id => '2011-11-11')
    end
  end
end

