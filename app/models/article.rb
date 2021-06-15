class Article < ApplicationRecord
  belongs_to :user
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content
  has_one_attached :cover
  has_many :seen_articles, dependent: :destroy

  enum media_type: { article: 0, event: 1, media: 3 }
  enum category: { generalities: 0, sexuality: 5, treatment: 2, food: 3, fertility: 4, diagnostic: 1, administrative: 7, sport: 6, research: 8 }

  validates :title, :content, :category, :media_type, :reading_time, :author, :cover_credit, :alt_text, presence: true
  validates :title, uniqueness: true
  validates :cover, attached: true
  validates :media_type, inclusion: { in: media_types.keys }
  validates :category, inclusion: { in: categories.keys }

  include PgSearch::Model
  pg_search_scope :search_by_content_and_title_and_author_and_tags,
    against: [:title, :author, :tags],
    associated_against: {
      rich_text_content: [:body]
    },
    using: {
      tsearch: { prefix: true }
    }
end
