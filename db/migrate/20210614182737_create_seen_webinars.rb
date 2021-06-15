class CreateSeenWebinars < ActiveRecord::Migration[6.0]
  def change
    create_table :seen_webinars do |t|
      t.references :user, null: false, foreign_key: true
      t.references :webinar, null: false, foreign_key: true
      t.boolean :seen, default: false
      t.timestamps
    end
  end
end
