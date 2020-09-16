class AddDisplayedToAlternativeTherapy < ActiveRecord::Migration[6.0]
  def change
    add_column :alternative_therapies, :displayed, :boolean, default: false
  end
end
