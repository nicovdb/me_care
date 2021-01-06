FactoryBot.define do
  factory :subject do
    user { nil }
    forum_category { nil }
    title { "MyString" }
    content { "MyText" }
  end
end
