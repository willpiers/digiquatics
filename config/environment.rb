# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
DigiQuatics::Application.initialize!

ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: '587',
  authentication: :plain,
  user_name: 'matchmike1313',
  password: 'jill1313',
  domain: 'digiquatics.com',
  enable_starttls_auto: true
}
