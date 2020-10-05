class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.integer :free_days
      t.string :code
      t.boolean :used
      t.references :user, foreign_key: true, optional: true

      t.timestamps
    end
  end
end
