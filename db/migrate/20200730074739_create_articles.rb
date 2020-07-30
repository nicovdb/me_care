class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.integer :media_type
      t.integer :category
      t.string :reading_time
      t.string :cover_credit

      t.timestamps
    end
  end
end
