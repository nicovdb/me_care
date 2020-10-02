class Coupon < ApplicationRecord
  belongs_to :user, optional: true
  validates :code, uniqueness: true
  validates :code, :free_days, presence: true
end
