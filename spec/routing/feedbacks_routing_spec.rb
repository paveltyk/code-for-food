require 'spec_helper'

describe FeedbacksController do
  describe 'routing' do

    it 'recognizes and generates GET #new' do
      { :get => "/feedbacks/new" }.should route_to(:controller => "feedbacks", :action => "new")
    end

    it 'recognizes and generates POST #create' do
      { :post => "/feedbacks/" }.should route_to(:controller => "feedbacks", :action => "create")
    end
  end
end

