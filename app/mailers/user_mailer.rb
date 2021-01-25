class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: 'Bienvenue sur easy endo !')
  end

  def webinar_subscription_confirmed
    @user = params[:user]
    @webinar = params[:webinar]
    mail(to: @user.email, subject: "Inscription au live '#{@webinar.title}' confirmée !")
  end

  def trial_end_soon
    @user = params[:user]
    mail(to: @user.email, subject: "Et si vous accédiez à easy endo en illimité ?")
  end
end
