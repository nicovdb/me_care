class CreateFamMemberAntes < ActiveRecord::Migration[6.0]
  def change
    create_table :fam_member_antes do |t|
      t.string :title

      t.timestamps
    end
  end
end
