class SeenWebinar < ApplicationRecord
  belongs_to :user
  belongs_to :webinar
end
