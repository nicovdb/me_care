class AddPriceToWebinars < ActiveRecord::Migration[6.0]
  def change
    add_monetize :webinars, :price, currency: { present: false }, amount: { default: 500 }
  end
end
