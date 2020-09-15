class AddDisplayedToDisease < ActiveRecord::Migration[6.0]
  def change
    add_column :diseases, :displayed, :boolean, default: false
  end
end
