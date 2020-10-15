class Webinar < ApplicationRecord
  has_rich_text :description
  enum category: { generalities: 0, diagnostic: 1, treatment: 2, food: 3, fertility: 4, sexuality: 5, sport: 6, administrative: 7, research: 8 }
  has_one_attached :speaker_picture
  monetize :price_cents

  validates :speaker_picture, attached: true
  validates :title, :start_at, :category, :speaker_name, :description, presence: true
end
