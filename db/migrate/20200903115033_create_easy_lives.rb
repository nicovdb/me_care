class CreateEasyLives < ActiveRecord::Migration[6.0]
  def change
    create_table :easy_lives do |t|
      t.string :speaker_name
      t.string :title
      t.datetime :start_at
      t.text :description
      t.integer :category

      t.timestamps
    end
  end
end
