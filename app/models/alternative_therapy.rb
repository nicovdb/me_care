class AlternativeTherapy < ApplicationRecord
  has_many :info_alternative_therapies, dependent: :destroy
end
