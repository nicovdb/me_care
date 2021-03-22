class CreateCouponCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :coupon_codes do |t|
      t.string :code
      t.boolean :used, default: false
      t.integer :free_months

      t.timestamps
    end
  end
end
