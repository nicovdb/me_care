class Infoendo < ApplicationRecord
  belongs_to :user

  has_rich_text :content
  has_one_attached :cover

  enum media_type: { video: 0, article: 1 }
  enum category: { generalities: 0, diagnostic: 1, treatment: 2, food: 3, fertility: 4, radiography: 5, exam: 6, administrative: 7 }

  validates :title, :content, :category, :media_type, :reading_time, :cover_credit, presence: true
  validates :cover, attached: true
  validates :media_type, inclusion: { in: media_types.keys }
  validates :category, inclusion: { in: categories.keys }

  include PgSearch::Model
  pg_search_scope :search_by_content_and_title,
    against: [:title],
    associated_against: {
      rich_text_content: [:body]
    },
    using: {
      tsearch: { prefix: true }
    }
end