class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :actuality
      t.boolean :algorythm
      t.boolean :forum
      t.boolean :info_endo
      t.boolean :webinar
      t.boolean :agenda
      t.string :stripe_id

      t.timestamps
    end
  end
end
