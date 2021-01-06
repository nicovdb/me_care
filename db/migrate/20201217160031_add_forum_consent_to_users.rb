class AddForumConsentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :forum_consent, :boolean, default: false
  end
end
