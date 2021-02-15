class ApplicationMailer < ActionMailer::Base
  default from: "L'équipe easy endo <#{ENV['DEFAULT_FROM_EMAIL']}>"
  layout 'mailer'
end
