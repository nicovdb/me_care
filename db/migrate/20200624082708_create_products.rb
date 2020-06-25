class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :actuality, default: false
      t.boolean :algorythm, default: false
      t.boolean :forum, default: false
      t.boolean :info_endo, default: false
      t.boolean :webinar, default: false
      t.boolean :agenda, default: false
      t.string :stripe_id

      t.timestamps
    end
  end
end
