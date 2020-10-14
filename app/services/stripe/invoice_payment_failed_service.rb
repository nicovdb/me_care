module Stripe
  class InvoicePaymentFailedService
    def call(event)
      @event = event
      @stripe_customer = @event.data.object.customer
      @user = User.find_by(stripe_id: @stripe_customer)
      StripeMailer.with(user: @user).invoice_payment_failed.deliver_now
    end
  end
end
