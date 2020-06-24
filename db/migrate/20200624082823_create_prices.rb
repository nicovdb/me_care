class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.references :product, null: false, foreign_key: true
      t.string :nickname
      t.string :stripe_id
      t.timestamps
    end
  end
end
