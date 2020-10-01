class Product < ApplicationRecord
  has_one :price, dependent: :destroy
end
