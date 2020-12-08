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
    rescue StandardError => e
      #StandardError("message")
      #Net::OpenTimeout tester en enlevant la wifi
      #ActiveRecord::RecordInvalid
      #user not find, tester avec faux id
      #e ou e.message
      channel = Rails.env.development? ? 'DEVELOPMENT' : 'PRODUCTION'
      Zapier::StripeError.new({ event: event, error: e.message, channel: channel, service: "CustomerSubscriptionDeleted" }).post_to_zapier
    end
  end
end
