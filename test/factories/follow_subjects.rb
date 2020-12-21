FactoryBot.define do
  factory :follow_subject do
    user { nil }
    subject { nil }
    seen { false }
  end
end
