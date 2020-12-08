FactoryBot.define do
  factory :webinar do
    title { "Micronutrition et endométriose" }
    start_at { Date.today + 2}
    speaker_name { "Nicoco VDB" }
    description { "Webinar de test" }
    category { 1 }
    speaker_picture { Rack::Test::UploadedFile.new('spec/files/logo.png', 'image/png') }
  end
end
