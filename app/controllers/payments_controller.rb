class PaymentsController < ApplicationController
  def new
    @webinar_subscription = current_user.webinar_subscriptions.where(state: 'pending').find(params[:webinar_subscription_id])
    authorize @webinar_subscription
  end
end
