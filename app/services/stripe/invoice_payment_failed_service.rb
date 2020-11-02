module Stripe
  class InvoicePaymentFailedService
    def call(event)
      stripe_customer_id = event.data.object.customer
      user = User.find_by(stripe_id: stripe_customer_id)

      StripeMailer.with(user: user).invoice_payment_failed.deliver_now
    end
  end
end
