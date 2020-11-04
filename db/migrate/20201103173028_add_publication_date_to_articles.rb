class AddPublicationDateToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :publication_date, :datetime
  end
end
