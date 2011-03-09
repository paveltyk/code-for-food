# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CodeForFood::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => '25',
  :domain => "code-for-food.info",
  :authentication => :plain,
  :user_name => ENV['SG_LOGIN'],
  :password => ENV['SG_PASS']
}

