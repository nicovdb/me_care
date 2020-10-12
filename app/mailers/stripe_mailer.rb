class StripeMailer < ApplicationMailer
  def trial_ended_without_card
    @user = params[:user]
    mail(to: @user.email, subject: "Votre période d'essai à easy Endo est terminée")
  end
end
