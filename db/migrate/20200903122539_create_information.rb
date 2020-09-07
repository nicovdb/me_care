class CreateInformation < ActiveRecord::Migration[6.0]
  def change
    create_table :information do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_of_birth
      t.integer :family_situation
      t.string :job
      t.integer :diagnosis_age
      t.integer :size
      t.float :weight
      t.float :imc
      t.boolean :family_antecedent
      t.integer :family_antecedent_origin
      t.boolean :children
      t.integer :children_number
      t.boolean :abortion
      t.integer :abortion_number
      t.boolean :pma
      t.boolean :endo_surgery
      t.integer :endo_surgery_number
      t.boolean :pain_center
      t.boolean :physiotherapist
      t.boolean :ostheopath
      t.boolean :terms_conditions
      t.boolean :auto_immune_antecedent
      t.boolean :alternative_therapy

      t.timestamps
    end
  end
end
