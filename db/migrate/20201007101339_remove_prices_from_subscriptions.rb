class RemovePricesFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :subscriptions, :price, index: true, foreign_key: true
    remove_reference :prices, :product, index: true, foreign_key: true
  end
end
