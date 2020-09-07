class Information < ApplicationRecord
  belongs_to :user
  enum family_situation: { maried: 0, relationship: 1, single: 2 }
end
