FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{(0...8).map { (65 + rand(26)).chr }.join}@sample.com" }
    password { "Password1%" }
    sequence(:pseudo) { (0...8).map { (65 + rand(26)).chr }.join }
    first_name { "Mon Prénom"}
    last_name { "Mon Nom"}
    stripe_id { "cus_00000000000000"}
  end

  trait(:admin) do
    admin { true }
  end

  trait(:confirmed) do
    after(:create) { |u| u.confirm }
  end

  trait(:without_set_stripe_customer) do
    after(:build) { |user|
      user.class.skip_callback(:create, :after, :set_stripe_customer, raise: false)
    }
  end

  trait(:without_set_trial) do
    after(:build) { |user|
      user.class.skip_callback(:create,
                               :after,
                               :set_trial, raise: false)
    }
  end
end
