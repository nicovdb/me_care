class Plan < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  monetize :price_cents
end
