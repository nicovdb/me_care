require 'rails_helper'
require 'stripe_mock'
require 'database_cleaner/active_record'

RSpec.describe Stripe::InvoicePaymentFailedService, type: :model do
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

    it "detects when the invoice payment fails" do
      before_count = ActionMailer::Base.deliveries.count
      request = StripeMock.mock_webhook_event('invoice.payment_failed', customer: user.stripe_id)
      described_class.new.call(request)
      expect(ActionMailer::Base.deliveries.count).to be > (before_count)
    end
end
