class Subscription < ApplicationRecord
  belongs_to :user
  enum st: { generalities: 0, sexuality: 5, treatment: 2, food: 3, fertility: 4, diagnostic: 1, administrative: 7, sport: 6, research: 8 }
end
