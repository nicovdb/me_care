class StripeMailer < ApplicationMailer
  def trial_ended_without_card
    @user = params[:user]
    mail(to: @user.email, subject: "Votre période d'essai à easy Endo est terminée")
  end

  def subscription_canceled
    @user = params[:user]
    mail(to: @user.email, subject: "Votre abonnement easy Endo est terminé")
  end

  def customer_first_sub
    @user = params[:user]
    @duration = params[:duration]
    @interval = params[:interval]
    @subscription = params[:subscription]
    mail(to: @user.email, subject: "Votre abonnement > easy endo en accès illimité !")
  end

  def customer_changed_plan
    @user = params[:user]
    @duration = params[:duration]
    @interval = params[:interval]
    @subscription = params[:subscription]
    mail(to: @user.email, subject: "Votre abonnement > easy endo en accès illimité ! ")
  end

  def invoice_payment_failed
    @user = params[:user]
    mail(to: @user.email, subject: "Votre paiement n'a pas fonctionné")
  end
end
