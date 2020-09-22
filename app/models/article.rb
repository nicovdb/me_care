class Article < ApplicationRecord
  belongs_to :user

  has_rich_text :content
  has_one_attached :cover

  enum media_type: { article: 0, event: 1, media: 3 }
  enum category: { generalities: 0, sexuality: 5, treatment: 2, food: 3, fertility: 4, diagnostic: 1, administrative: 7, sport: 6, research: 8 }

  validates :title, :content, :category, :media_type, :reading_time, :author, :cover_credit, presence: true
  validates :cover, attached: true
  validates :media_type, inclusion: { in: media_types.keys }
  validates :category, inclusion: { in: categories.keys }

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
