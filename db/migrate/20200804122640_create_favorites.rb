class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, foreign_key: true, optional: true

      t.timestamps
    end
  end
end
