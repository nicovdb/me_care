class RenameEasyLiveToWebinar < ActiveRecord::Migration[6.0]
  def change
    rename_table :easy_lives, :webinars
  end
end
