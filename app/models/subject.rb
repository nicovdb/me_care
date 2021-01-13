class Subject < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_rich_text :content
  has_many :follow_subjects, dependent: :destroy
  belongs_to :user
  belongs_to :forum_category
  validates :title, uniqueness: true
end
