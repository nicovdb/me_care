module Zapier
  class StripeError < Zapier::Base
    def call_operation
      HTTParty.post(ENV["ZAP_STRIPE_ERROR"], body: params)
    end

    def params
      {
        error: resource[:error],
        channel: resource[:channel],
        service: resource[:service],
        event: resource[:event]
      }
    end
  end
end
