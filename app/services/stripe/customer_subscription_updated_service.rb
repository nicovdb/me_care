module Stripe
  class CustomerSubscriptionUpdatedService
    def call(event)
      stripe_subscription = event.data.object
      puts stripe_subscription
      @user = User.find_by(stripe_id: stripe_subscription.customer)
      @user.subscription.update(
        status: stripe_subscription.status,
        end_date: Time.at(stripe_subscription.current_period_end).to_date
      )
    end
  end
end
