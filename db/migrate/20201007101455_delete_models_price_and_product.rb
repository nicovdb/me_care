class DeleteModelsPriceAndProduct < ActiveRecord::Migration[6.0]
  def change
    drop_table :products
    drop_table :prices
  end
end
