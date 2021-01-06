class FollowSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  validates_uniqueness_of :user_id, scope: [:subject_id]
end
