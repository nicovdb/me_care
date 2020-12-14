class AddDefaultValuesToDailySymptom < ActiveRecord::Migration[6.0]
  def change
    change_column_default :daily_symptoms, :pain_level, 0
    change_column_default :daily_symptoms, :blood_level, 0
    change_column_default :daily_symptoms, :digestive_trouble_level, 0
    change_column_default :daily_symptoms, :stress_level, 0
    change_column_default :daily_symptoms, :insomnia_level, 0
    change_column_default :daily_symptoms, :sport, false
    change_column_default :daily_symptoms, :emergency, false
    change_column_default :daily_symptoms, :analgesic, false
  end
end
