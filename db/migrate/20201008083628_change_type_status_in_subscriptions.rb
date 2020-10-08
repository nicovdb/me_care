class ChangeTypeStatusInSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :subscriptions, :status
    add_column :subscriptions, :status, :integer, default: 0
  end
end
