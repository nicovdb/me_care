class AddColumnsToWebinarSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :webinar_subscriptions, :state, :string
    add_monetize :webinar_subscriptions, :amount, currency: { present: false }
    add_column :webinar_subscriptions, :checkout_session_id, :string
  end
end
