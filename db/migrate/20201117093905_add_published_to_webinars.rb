class AddPublishedToWebinars < ActiveRecord::Migration[6.0]
  def change
    add_column :webinars, :published, :boolean, default: false
  end
end
