module Stripe
  class CustomerSubscriptionDeletedService
    def call(event)
      stripe_subscription = event.data.object
      @user = User.find_by(stripe_id: stripe_subscription.customer)
      @user.subscription.update(
        status: stripe_subscription.status,
        end_date: Time.at(stripe_subscription.current_period_end).to_date
      )
      StripeMailer.with(user: @user).subscription_canceled.deliver_now
    end
  end
end
