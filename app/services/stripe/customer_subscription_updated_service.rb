module Stripe
  class CustomerSubscriptionUpdatedService
    def call(event)
      stripe_subscription = event.data.object
      @user = User.find_by(stripe_id: stripe_subscription.customer)
      @user.subscription.update(
        status: stripe_subscription.status,
        end_date: Time.at(stripe_subscription.current_period_end).to_date
      )

      @customer = Stripe::Customer.retrieve(stripe_subscription.customer)
      @subscription = Stripe::Subscription.retrieve(stripe_subscription.id)

      check_trial_end
    end

    private

    def check_trial_end
      cards_count = @customer['sources']['total_count']
      now = DateTime.now
      trial_start = Time.at(@subscription['start_date']).to_datetime
      days_since = now.day - trial_start.day

      if days_since == 15 && cards_count < 1
        StripeMailer.with(user: @user).trial_ended_without_card.deliver_now
      end
    end
  end
end
