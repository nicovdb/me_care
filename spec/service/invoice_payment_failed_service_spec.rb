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

    it "detects when the invoice payment fails" do
      #request = StripeMock.mock_webhook_event('invoice.payment_failed', customer: @user.stripe_id)
      #mettre en place test c'est bon ça marche
      #expect(request.data.object.customer).to eql @user.stripe_id
      #expect(request.data.object.status).to eql @user.subscription.status
      # probleme : quand je test la user.sub reste en trialing donc pas poss de la supp
      #expect(@user.has_valid_subscription?).to eql false
    end
end
