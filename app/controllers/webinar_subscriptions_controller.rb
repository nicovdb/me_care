class WebinarSubscriptionsController < ApplicationController
  def create
    @webinar = Webinar.find(params[:webinar_id])
    @webinar_subscription = WebinarSubscription.new(user: current_user, webinar: @webinar, state: "paid")
    authorize @webinar_subscription
    @webinar_subscription.save if current_user.has_valid_subscription?
    redirect_to webinar_path(@webinar)
  end

  def show
    @webinar_subscription = current_user.webinar_subscriptions.find(params[:id])
  end

  private

  def webinar_subscription_params
    params.require(:webinar_subscription).permit(:webinar_id)
  end
end
