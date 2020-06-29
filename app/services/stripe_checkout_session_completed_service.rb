class StripeCheckoutSessionCompletedService
  def call(event)
    # retrieve subscription data
    user = User.find_by(id: event.data.object.client_reference_id)

    subscription_stripe = Stripe::Subscription.retrieve(event.data.object.subscription)

    price_stripe_id = subscription_stripe.plan.id

    price = Price.find_by(stripe_id: price_stripe_id)

    # create subscription
    subscription = Subscription.new(user: user, price: price, stripe_id: subscription_stripe.id, start_date: Time.at(subscription_stripe.current_period_start), end_date: Time.at(subscription_stripe.current_period_end), status: "active")
    subscription.save
  end
end
