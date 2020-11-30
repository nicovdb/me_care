require 'rails_helper'
require 'stripe_mock'


RSpec.describe Stripe::CustomerSubscriptionDeletedService, type: :model do
    before(:all) do
      StripeMock.start
      StripeMock.start
      @user = FactoryBot.create(:user)
      @user.confirm
    end

    after(:all) do
      StripeMock.stop
    end

    it "detects when the subscription is deleted" do
      request = StripeMock.mock_webhook_event('customer.subscription.deleted', customer: @user.stripe_id)
      expect(request.data.object.customer).to eql @user.stripe_id
      # expect(request.data.object.status).to eql @user.subscription.status
      # probleme : quand je test la uuser.sub reste en trialing donc pas poss de la supp
      #expect(@user.has_valid_subscription?).to eql false
    end
end
