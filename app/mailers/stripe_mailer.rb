class StripeMailer < ApplicationMailer
  def trial_will_end
    @user = params[:user]
    @trial_end = params[:trial_end]
    mail(to: @user.email, subject: "Votre période d'essai à easy Endo est bientôt terminée")
  end
end
