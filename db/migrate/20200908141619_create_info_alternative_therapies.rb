class CreateInfoAlternativeTherapies < ActiveRecord::Migration[6.0]
  def change
    create_table :info_alternative_therapies do |t|
      t.references :information, null: false, foreign_key: true
      t.references :alternative_therapy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
