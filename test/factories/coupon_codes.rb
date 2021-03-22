FactoryBot.define do
  factory :coupon_code do
    code { "MyString" }
    used { false }
    free_months { 1 }
  end
end
