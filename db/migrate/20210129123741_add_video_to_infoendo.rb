class AddVideoToInfoendo < ActiveRecord::Migration[6.0]
  def change
    add_column :infoendos, :video, :string
  end
end
