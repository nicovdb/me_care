class Disease < ApplicationRecord
  has_many :info_diseases, dependent: :destroy
end
