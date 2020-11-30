require 'rails_helper'
require 'stripe_mock'


RSpec.describe Stripe::CheckoutSessionCompletedService, type: :model do
    before(:all) do
      StripeMock.start
      StripeMock.start
      @user = FactoryBot.create(:user)
    end

    after(:all) do
      StripeMock.stop
    end

    it "detects when the checkout session is completed" do
      request = StripeMock.mock_webhook_event('checkout.session.completed')
      event_response = StripeHelper::IncomingWebhook.event_handler(request)
      # request = StripeMock.mock_webhook_event('customer.source.created', metadata: {user_id: @user.id})
      # event_response = StripeHelper::IncomingWebhook.event_handler(request)
      expect(event_response[:type]).to eql request.type
      expect(event_response[:stripe_customer_id]).to eql request.data.object.id
      expect(event_response[:user_id]).to eql request.data.object.metadata.user_id
    end

    # it "detects when the stripe customer's credit card is about to expire" do
    #   request = StripeMock.mock_webhook_event('customer.created', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   request = StripeMock.mock_webhook_event('customer.source.created', metadata: {user_id: @user.id})
    #   request = StripeMock.mock_webhook_event('customer.source.expiring', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   expect(event_response[:type]).to eql request.type
    #   expect(event_response[:stripe_customer_id]).to eql request.data.object.id
    #   expect(event_response[:user_id]).to eql request.data.object.metadata.user_id
    # end

    # it "detects when a charge fails" do
    #   request = StripeMock.mock_webhook_event('customer.created', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   request = StripeMock.mock_webhook_event('customer.source.created', metadata: {user_id: @user.id})
    #   request = StripeMock.mock_webhook_event('charge.failed', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   expect(event_response[:type]).to eql request.type
    #   expect(event_response[:stripe_customer_id]).to eql request.data.object.id
    #   expect(event_response[:user_id]).to eql request.data.object.metadata.user_id
    # end


    # it "detects when a charge succeeds" do
    #   request = StripeMock.mock_webhook_event('customer.created', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   request = StripeMock.mock_webhook_event('customer.source.created', metadata: {user_id: @user.id})
    #   request = StripeMock.mock_webhook_event('charge.succeeded', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   expect(event_response[:type]).to eql request.type
    #   expect(event_response[:stripe_customer_id]).to eql request.data.object.id
    #   expect(event_response[:user_id]).to eql request.data.object.metadata.user_id
    # end

    # it "detects when a customer files a dispute with credit card company/bank" do
    #   request = StripeMock.mock_webhook_event('customer.created', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   request = StripeMock.mock_webhook_event('customer.source.created', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   request = StripeMock.mock_webhook_event('charge.dispute.created', metadata: {user_id: @user.id})
    #   event_response = StripeHelper::IncomingWebhook.event_handler(request)
    #   expect(event_response[:type]).to eql request.type
    #   expect(event_response[:user_id]).to eql request.data.object.metadata.user_id
    # end
end
