FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{(0...8).map { (65 + rand(26)).chr }.join}@sample.com" }
    password { "Password1%" }
    sequence(:pseudo) { (0...8).map { (65 + rand(26)).chr }.join }
    first_name { "Mon Prénom"}
    last_name { "Mon Nom"}
  end
  factory :admin do
    sequence(:email) { |n| "test-#{(0...8).map { (65 + rand(26)).chr }.join}@sample.com" }
    password { "Password1%" }
    sequence(:pseudo) { (0...8).map { (65 + rand(26)).chr }.join }
    first_name { "Mon Prénom"}
    last_name { "Mon Nom"}
    admin { true }
  end
end
