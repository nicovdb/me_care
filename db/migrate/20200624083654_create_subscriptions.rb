class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :price, null: false, foreign_key: true
      t.datetime :start_date
      t.string :stripe_id

      t.timestamps
    end
  end
end
