class AddUnitAmountToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :prices, :unit_amount, :integer
  end
end
