class CreateInfoendos < ActiveRecord::Migration[6.0]
  def change
    create_table :infoendos do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.integer :category
      t.string :reading_time
      t.text :content
      t.integer :media_type
      t.string :cover_credit

      t.timestamps
    end
  end
end
