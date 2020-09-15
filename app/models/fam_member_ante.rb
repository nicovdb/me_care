class FamMemberAnte < ApplicationRecord
  has_many :info_fam_member_antes, dependent: :destroy
end
