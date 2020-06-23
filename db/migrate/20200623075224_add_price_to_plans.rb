class AddPriceToPlans < ActiveRecord::Migration[6.0]
  def change
    add_monetize :plans, :price, currency: { present: false }
  end
end
