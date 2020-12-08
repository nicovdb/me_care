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

    let(:user) { FactoryBot.create(:user, :confirmed) }
    let(:webinar) { FactoryBot.create(:webinar) }

    it "detects when the checkout session is completed" do
      web_sub_counter = WebinarSubscription.count
      request = StripeMock.mock_webhook_event('checkout.session.completed', customer: user.stripe_id, name: webinar.title)
      described_class.new.call(request)
      expect(WebinarSubscription.count).not_to eq(web_sub_counter)
    end
end
