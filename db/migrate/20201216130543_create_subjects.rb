class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :forum_category, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
