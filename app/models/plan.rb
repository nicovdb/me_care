class Plan < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  monetize :price_cents, symbol_first: false
end
