class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :price
  has_one :product, through: :price
end
