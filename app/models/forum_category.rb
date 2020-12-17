class ForumCategory < ApplicationRecord
  has_many :subjects, dependent: :destroy
  validates :name, uniqueness: true
end
