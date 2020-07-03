class SubscriptionsController < ApplicationController

  before_action :set_subscription, only: [:destroy]

  def index
    @subscriptions = policy_scope(Subscription)
  end

  def destroy
    CancelSubscriptionService.new(subscription: @subscription).call
    flash[:notice] = 'Votre abonnement a bien été arrêté !'
    redirect_to subscriptions_path
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
    authorize @subscription
  end


end
