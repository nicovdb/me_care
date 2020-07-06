ActionMailer::Base.smtp_settings = {
  domain: 'https://me-care-staging.herokuapp.com/',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  password:       ENV['SENDGRID_API_KEY']
}
