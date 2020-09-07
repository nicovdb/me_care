class CreateWebinarSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :webinar_subscriptions do |t|
      t.references :webinar, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
