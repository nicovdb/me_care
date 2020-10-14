module Stripe
  class InvoicePaymentFailedService
    def call(event)
      stripe_customer_id = event.data.object.customer
      stripe_customer = Stripe::Customer.retrieve(stripe_customer_id)
      stripe_subscription_id = event.data.object.subscription
      stripe_subscription = Stripe::Subscription.retrieve(stripe_subscription_id)
      cards_count = stripe_customer['sources']['total_count']
      now = DateTime.now
      trial_start = Time.at(stripe_subscription['start_date']).to_datetime
      days_since = now.day - trial_start.day
      user = User.find_by(stripe_id: stripe_customer_id)

      if days_since == 15 && cards_count < 1
        StripeMailer.with(user: user).trial_ended_without_card.deliver_now
      else
        StripeMailer.with(user: user).invoice_payment_failed.deliver_now
      end
    end
  end
end
