class AddBalisesToNewsSavoir < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :alt_text, :string, default: ""
    add_column :infoendos, :alt_text, :string, default: ""
  end
end
