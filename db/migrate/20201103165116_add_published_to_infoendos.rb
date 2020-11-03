class AddPublishedToInfoendos < ActiveRecord::Migration[6.0]
  def change
    add_column :infoendos, :published, :boolean, default: false
  end
end
