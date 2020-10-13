module Stripe
  class CustomerSubscriptionUpdatedService
    def call(event)
      @event = event
      @stripe_subscription = @event.data.object
      @user = User.find_by(stripe_id: @stripe_subscription.customer)
      @user.subscription.update(
        status: @stripe_subscription.status,
        end_date: Time.at(@stripe_subscription.current_period_end).to_date
      )

      @customer = Stripe::Customer.retrieve(@stripe_subscription.customer)
      @subscription = Stripe::Subscription.retrieve(@stripe_subscription.id)

      check_trial_end
      check_change_price
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

    def check_change_price
      status = @stripe_subscription.status
      price_id = @stripe_subscription&.items&.data[0]&.price&.id
      previous_price_id = @event.data&.previous_attributes&.items&.data[0]&.price&.id

      if previous_price_id && (previous_price_id != price_id) && status == "active"
        @subscription_duration = @stripe_subscription.items.data[0].plan.interval_count
        @interval = @stripe_subscription.items.data[0].plan.interval
        @interval == "month" ? @interval = "mois" : @interval = "an"
        StripeMailer.with(user: @user, duration: @subscription_duration, interval: @interval).customer_changed_plan.deliver_now
      end
    end
  end
end
