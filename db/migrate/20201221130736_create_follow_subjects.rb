class CreateFollowSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_subjects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
