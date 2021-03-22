class CouponCode < ApplicationRecord
  validates :code, presence: true
  validates :code, uniqueness: true
  validates :free_months, presence: true
end
