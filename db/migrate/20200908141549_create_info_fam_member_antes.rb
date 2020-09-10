class CreateInfoFamMemberAntes < ActiveRecord::Migration[6.0]
  def change
    create_table :info_fam_member_antes do |t|
      t.references :information, null: false, foreign_key: true
      t.references :fam_member_ante, null: false, foreign_key: true

      t.timestamps
    end
  end
  FamMemberAnte.create(title: "aunt")
end
