# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CodeForFood::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => '587',
  :domain => "altoros.net",
  :authentication => :plain,
  :enable_starttls_auto => true,
  :user_name => ENV['SMTP_LOGIN'],
  :password => ENV['SMTP_PASSWORD']
}

