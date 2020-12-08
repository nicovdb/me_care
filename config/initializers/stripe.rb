if Rails.env == 'production'
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key      => ENV['STRIPE_SECRET_KEY'],
    :signing_secret =>  ENV['STRIPE_WEBHOOK_SECRET_KEY']
  }
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
elsif Rails.env == 'development'
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key      => ENV['STRIPE_SECRET_KEY'],
    :signing_secret =>  ENV['STRIPE_WEBHOOK_SECRET_KEY']
  }
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
elsif Rails.env == 'test'
  Rails.configuration.stripe = {
    :publishable_key => ENV['TEST_STRIPE_PUBLISHABLE_KEY'],
    :secret_key      => ENV['TEST_STRIPE_SECRET_KEY'],
    :signing_secret => ENV['TEST_STRIPE_WEBHOOK_SECRET_KEY']
  }
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
end


Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = Rails.configuration.stripe[:signing_secret]

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.updated', Stripe::CustomerSubscriptionUpdatedService.new
  events.subscribe 'customer.subscription.deleted', Stripe::CustomerSubscriptionDeletedService.new
  events.subscribe 'invoice.payment_failed', Stripe::InvoicePaymentFailedService.new
  events.subscribe 'checkout.session.completed', Stripe::CheckoutSessionCompletedService.new
end
