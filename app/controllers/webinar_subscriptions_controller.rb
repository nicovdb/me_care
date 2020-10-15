class WebinarSubscriptionsController < ApplicationController
  def create
    @webinar = Webinar.find(params[:webinar_id])
    if current_user.has_valid_subscription?
      @webinar_subscription = WebinarSubscription.new(user: current_user, webinar: @webinar, state: "paid")
      authorize @webinar_subscription

      @webinar_subscription.save
      @webinar_subscription.send_confirmation_email
      @webinar_subscription.send_to_mailchimp if Rails.env.production?
      redirect_to webinar_path(@webinar)
    else
      @webinar_subscription = WebinarSubscription.new(webinar: @webinar, amount: @webinar.price, state: 'pending', user: current_user)
      authorize @webinar_subscription
      @webinar_subscription.save

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @webinar.title,
          amount: @webinar.price_cents,
          currency: 'eur',
          quantity: 1
        }],
        success_url: webinar_url(@webinar),
        cancel_url: webinar_url(@webinar)
      )

      @webinar_subscription.update(checkout_session_id: session.id)
      redirect_to new_webinar_subscription_payment_path(@webinar_subscription)
    end
  end

  def show
    @webinar_subscription = current_user.webinar_subscriptions.find(params[:id])
  end

  private

  def webinar_subscription_params
    params.require(:webinar_subscription).permit(:webinar_id)
  end
end
