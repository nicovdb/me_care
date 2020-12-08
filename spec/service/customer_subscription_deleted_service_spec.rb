require 'rails_helper'
require 'database_cleaner/active_record'
require 'stripe_mock'

RSpec.describe Stripe::CustomerSubscriptionDeletedService, type: :model do
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

  it "detects when the subscription is deleted" do
    request = StripeMock.mock_webhook_event('customer.subscription.deleted', customer: 'cus_00000000000000')
    expect(request.data.object.customer).to eql subscription.user.stripe_id
    expect(request.data.object.status).to eql "canceled"
    described_class.new.call(request)
    subscription.reload
    expect(subscription.end_date).to eql Time.at(request.data.object.current_period_end).to_date
    expect(subscription.status).to eql "canceled"
  end
end
