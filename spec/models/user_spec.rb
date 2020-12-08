require 'rails_helper'
require 'database_cleaner/active_record'


RSpec.describe User, type: :model do
  DatabaseCleaner.strategy = :truncation
  before(:each) do
    DatabaseCleaner.start
    StripeMock.start
  end

  after(:each) do
    StripeMock.stop
    DatabaseCleaner.clean
  end
  let(:user) { FactoryBot.create(:user) }
  it "is initialized with a stripe id" do
    expect(user.stripe_id).not_to eql nil
  end
end
