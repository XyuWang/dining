# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dining::Application.initialize!

 Dining::Application.configure do
  config.action_mailer.delivery_method = :smtp
end

ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "chihuo0s.com",
    :authentication => "plain",
    :user_name => "chihuo0s",
    :password => "qdchihuo0s",
    :enable_starttls_auto => true,
    :authentication  => :login
}
