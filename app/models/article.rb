class Article < ApplicationRecord
  belongs_to :user

  has_rich_text :content
  has_one_attached :cover

  validates :title, :content, :category, :media_type, :reading_time, :author, :cover_credit, presence: true
  validates :cover, attached: true

  enum media_type: { article: 0, event: 1, media: 3 }
  enum category: { generalities: 0, diagnostic: 1, treatment: 2, food: 3, fertility: 4, sexuality: 5, sport: 6, administrative: 7, research: 8 }

  include PgSearch::Model
  pg_search_scope :search_by_content_and_title_and_author,
    against: [:title, :author],
    associated_against: {
      rich_text_content: [:body]
    },
    using: {
      tsearch: { prefix: true }
    }
end
