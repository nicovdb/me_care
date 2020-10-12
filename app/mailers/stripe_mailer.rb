class StripeMailer < ApplicationMailer
  def trial_ended_without_card
    @user = params[:user]
    mail(to: @user.email, subject: "Votre période d'essai à easy Endo est terminée")
  end

  def customer_changed_plan
    @user = params[:user]
    @duration = params[:duration]
    @interval = params[:interval]
    mail(to: @user.email, subject: "Vous avez changé d'abonnement")
  end
end
