class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: 'Bienvenue chez Easy Endo')
  end

  def webinar_subscription_confirmed
    @user = params[:user]
    @webinar = params[:webinar]
    mail(to: @user.email, subject: "Inscription au live '#{@webinar.title}' confirmée !")
  end
end
