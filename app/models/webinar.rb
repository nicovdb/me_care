class Webinar < ApplicationRecord
  has_rich_text :description
  enum category: { generalities: 0, diagnostic: 1, treatment: 2, food: 3, fertility: 4, sexuality: 5, sport: 6, administrative: 7, research: 8 }
  has_one_attached :speaker_picture
  after_create :send_to_mailchimp #if Rails.env.production?

  private

  def send_to_mailchimp
    Zapier::WebinarCreated.new(self).post_to_zapier
  end
end
