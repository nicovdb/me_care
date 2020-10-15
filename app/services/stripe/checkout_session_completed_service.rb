module Stripe
  class CheckoutSessionCompletedService
    def call(event)
      webinar_subscription = WebinarSubscription.find_by(checkout_session_id: event.data.object.id)
      webinar_subscription.update(state: 'paid')
      webinar_subscription.send_confirmation_email
      webinar_subscription.send_to_mailchimp if Rails.env.production?
    end
  end
end
