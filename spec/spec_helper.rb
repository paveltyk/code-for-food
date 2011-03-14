ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'authlogic/test_case'
require 'webrat'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

include Authlogic::TestCase

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
end

Webrat.configure do |config|
  config.mode = :rails
end

