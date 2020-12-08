module Stripe
  class CheckoutSessionCompletedService
    def call(event)
      if event.data.object.mode == "payment"
        user = User.find_by(stripe_id: event.data.object.customer)
        webinar = Webinar.find_by(title: event.data.object.display_items[0].custom.name)
        amount = event.data.object.amount_total.to_i
        @webinar_subscription = WebinarSubscription.new(user: user, webinar: webinar, state: "paid", amount_cents: amount)
        @webinar_subscription.save
      end
    rescue StandardError => e
      channel = Rails.env.development? ? 'DEVELOPMENT' : 'PRODUCTION'
      Zapier::StripeError.new({ event: event, error: e.message, channel: channel, service: "StripeCheckoutSessionCompleted" }).post_to_zapier
    end
  end
end
