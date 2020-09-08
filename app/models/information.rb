class Information < ApplicationRecord
  has_many :info_diseases
  has_many :diseases, through: :info_diseases
  has_many :info_alternative_therapies
  has_many :alternative_therapies, through: :info_alternative_therapies
  has_many :info_fam_member_antes
  has_many :fam_member_antes, through: :info_fam_member_antes
  belongs_to :user
  enum family_situation: { maried: 0, relationship: 1, single: 2 }
end
