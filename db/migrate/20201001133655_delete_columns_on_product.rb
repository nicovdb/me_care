class DeleteColumnsOnProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :actuality
    remove_column :products, :algorythm
    remove_column :products, :forum
    remove_column :products, :info_endo
    remove_column :products, :webinar
    remove_column :products, :agenda
  end
end
