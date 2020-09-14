class Infoendo < ApplicationRecord
  belongs_to :user

  has_rich_text :content
  has_one_attached :cover

  enum media_type: { video: 0, article: 1 }
  enum category: { generalities: 0, diagnostic: 1, treatment: 2, food: 3, fertility: 4, radiography: 5, exam: 6, administrative: 7 }
end
