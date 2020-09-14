class AddInfoendoToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_reference :favorites, :infoendo, foreign_key: true, optional: true
  end
end
