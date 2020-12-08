class DailySymptom < ApplicationRecord
  belongs_to :user
  validates :pain_level, inclusion: { in: 0..10 }, allow_nil: true
  validates :blood_level, inclusion: { in: 0..5 }, allow_nil: true
  validates :digestive_trouble_level, inclusion: { in: 0..5 }, allow_nil: true
  validates :stress_level, inclusion: { in: 0..5 }, allow_nil: true
  validates :insomnia_level, inclusion: { in: 0..5 }, allow_nil: true
end
