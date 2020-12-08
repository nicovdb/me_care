class CreateDailySymptoms < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_symptoms do |t|
      t.references :user, null: false, foreign_key: true
      t.date :day
      t.integer :pain_level
      t.integer :blood_level
      t.integer :digestive_trouble_level
      t.integer :stress_level
      t.integer :insomnia_level
      t.boolean :sport
      t.boolean :emergency
      t.boolean :analgesic
      t.text :notes

      t.timestamps
    end
  end
end
