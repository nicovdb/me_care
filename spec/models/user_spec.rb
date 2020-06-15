require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do
  end

  # describe "Validations" do
  #   it { should validate_presence_of(:bidder) }
  # end

  context 'associations' do
    it { should have_one(:plan) }
    it { should have_one(:subscription) }
  end
end
