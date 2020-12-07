require 'rails_helper'
require 'stripe_mock'
require 'database_cleaner/active_record'


RSpec.describe Stripe::CheckoutSessionCompletedService, type: :model do
    DatabaseCleaner.strategy = :truncation
    before(:all) do
      DatabaseCleaner.start
      StripeMock.start
    end

    after(:all) do
      StripeMock.stop
      DatabaseCleaner.clean
    end

    it "detects when the checkout session is completed" do
      request = StripeMock.mock_webhook_event('checkout.session.completed')
      #byebug
      #écrire test et rappeler service manuellement

      #event_response = StripeHelper::IncomingWebhook.event_handler(request)
      # request = StripeMock.mock_webhook_event('customer.source.created', metadata: {user_id: @user.id})
      # event_response = StripeHelper::IncomingWebhook.event_handler(request)
      # expect(event_response[:type]).to eql request.type
      # expect(event_response[:stripe_customer_id]).to eql request.data.object.id
      # expect(event_response[:user_id]).to eql request.data.object.metadata.user_id
    end
end
