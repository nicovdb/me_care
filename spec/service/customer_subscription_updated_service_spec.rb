require 'rails_helper'
require 'stripe_mock'
require 'database_cleaner/active_record'

RSpec.describe Stripe::CustomerSubscriptionUpdatedService, type: :model do
    DatabaseCleaner.strategy = :truncation
    before(:all) do
      DatabaseCleaner.start
      StripeMock.start
    end

    after(:all) do
      StripeMock.stop
      DatabaseCleaner.clean
    end

    let(:subscription) { FactoryBot.create(:subscription) }

    it "detects when the subscription is updated" do
      request = StripeMock.mock_webhook_event('customer.subscription.updated', {customer: 'cus_00000000000000', nickname: 'test'})
      expect(request.data.object.customer).to eql subscription.user.stripe_id
      described_class.new.call(request)
      subscription.reload
      expect(subscription.end_date).to eql Time.at(request.data.object.current_period_end).to_date
      expect(subscription.status).to eql request.data.object.status
    end
end
