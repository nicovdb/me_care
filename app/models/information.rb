class Information < ApplicationRecord
  has_many :info_diseases, dependent: :destroy
  has_many :diseases, through: :info_diseases
  accepts_nested_attributes_for :diseases
  has_many :info_alternative_therapies, dependent: :destroy
  has_many :alternative_therapies, through: :info_alternative_therapies
  accepts_nested_attributes_for :alternative_therapies
  has_many :info_fam_member_antes, dependent: :destroy
  has_many :fam_member_antes, through: :info_fam_member_antes
  belongs_to :user

  enum family_situation: { maried: 0, relationship: 1, single: 2 }
end
