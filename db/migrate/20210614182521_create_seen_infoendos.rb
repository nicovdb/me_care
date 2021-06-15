class CreateSeenInfoendos < ActiveRecord::Migration[6.0]
  def change
    create_table :seen_infoendos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :infoendo, null: false, foreign_key: true
      t.boolean :seen, default: false
      t.timestamps
    end
  end
end
