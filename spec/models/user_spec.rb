require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    StripeMock.start
    @user = FactoryBot.create(:user)
    #@user = User.handle_creation(user_data[:name], user_data[:email])
  end

  after(:each) do
    StripeMock.stop
  end

  it "is initialized with nil stripe account fields" do
    user = FactoryBot.create(:user)
    #user = User.handle_creation(create_user[:name], create_user[:email])
    expect(user.stripe_id).not_to eql nil
    #expect(user.payment_method_added).to eql false
    #expect(user.payment_method_valid).to eql false
    #expect(user.is_problematic).to eql true
  end
end
