class AddTagsToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :tags, :string
  end
end
