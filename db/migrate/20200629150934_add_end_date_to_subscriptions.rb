class AddEndDateToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :end_date, :date
    change_column :subscriptions, :start_date, :date
  end
end
