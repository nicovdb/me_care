class CreateInfoDiseases < ActiveRecord::Migration[6.0]
  def change
    create_table :info_diseases do |t|
      t.references :information, null: false, foreign_key: true
      t.references :disease, null: false, foreign_key: true

      t.timestamps
    end
  end
end
