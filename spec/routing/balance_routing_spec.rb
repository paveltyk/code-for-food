require 'spec_helper'

describe BalanceController do
  describe 'routing' do

    it 'recognizes and generates GET #show' do
      { :get => "/balance" }.should route_to(:controller => "balance", :action => "show")
    end
  end
end

