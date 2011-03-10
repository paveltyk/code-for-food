require 'spec_helper'

describe ReportsController do
  describe 'routing' do
    it 'recognizes and generates #provider' do
      { :get => 'menus/2011-11-11/reports/provider' }.should route_to(:controller => 'reports', :action => 'provider', :id => '2011-11-11')
    end
  end
end

