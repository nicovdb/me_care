require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    StripeMock.start
    @user = FactoryBot.create(:user)
  end

  after(:each) do
    StripeMock.stop
  end

  it "is initialized with a stripe id" do
    user = FactoryBot.create(:user)
    expect(user.stripe_id).not_to eql nil
  end
end
