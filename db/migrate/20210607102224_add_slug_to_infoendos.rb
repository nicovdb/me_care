class AddSlugToInfoendos < ActiveRecord::Migration[6.0]
  def change
    add_column :infoendos, :slug, :string
    add_index :infoendos, :slug, unique: true
  end
end
