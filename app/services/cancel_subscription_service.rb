class CancelSubscriptionService

  def initialize(args)
    @subscription = args[:subscription]
  end

  def call
    # retrieve subscription
    stripe_subscription = Stripe::Subscription.retrieve(@subscription.stripe_id)
    stripe_subscription.delete
    @subscription.update(status: 'cancelled')
  end
end
