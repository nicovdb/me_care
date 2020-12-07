FactoryBot.define do
  factory :subscription do
    start_date { Date.today }
    end_date { Date.today + 15 }
    status { "trialing" }
    association :user, factory: %i[user confirmed without_set_stripe_customer without_set_trial]
  end
end
