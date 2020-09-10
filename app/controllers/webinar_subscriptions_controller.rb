class WebinarSubscriptionsController < ApplicationController
  def create
    @webinar_subscription = WebinarSubscription.new
    @webinar_subscription.user = current_user
    @webinar_subscription.webinar = Webinar.find(params[:webinar_id])
    authorize @webinar_subscription

    @webinar_subscription.save
    redirect_to webinar_path(@webinar_subscription.webinar)
  end

  def webinar_subscription_params
    params.require(:webinar_subscription).permit(:webinar_id)
  end
end
