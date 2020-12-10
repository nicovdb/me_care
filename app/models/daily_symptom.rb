class DailySymptom < ApplicationRecord
  belongs_to :user
  validates :pain_level, inclusion: { in: 0..10 }, allow_nil: true
  validates :blood_level, inclusion: { in: 0..5 }, allow_nil: true
  validates :digestive_trouble_level, inclusion: { in: 0..5 }, allow_nil: true
  validates :stress_level, inclusion: { in: 0..5 }, allow_nil: true
  validates :insomnia_level, inclusion: { in: 0..5 }, allow_nil: true

  def symptoms_name_and_color
    symptoms = []
    if pain_level != nil && pain_level != 0
      symptoms << {name: "pain", color: "#FDA55E"}
    end
    if blood_level != nil && blood_level != 0
      symptoms << {name: "blood", color: "#DB9497"}
    end
    if digestive_trouble_level != nil && digestive_trouble_level != 0
      symptoms << {name: "digestiveTrouble", color: "#8C97CF"}
    end
    if stress_level != nil && stress_level != 0
      symptoms << {name: "stress", color: "#B9B9B9"}
    end
    if insomnia_level != nil && insomnia_level != 0
      symptoms << {name: "insomnia", color: "#FFF185"}
    end
    if sport
      symptoms << {name: "sport", color: "#B0CFE8"}
    end
    if analgesic
      symptoms << {name: "analgesic", color: "#9ABCC1"}
    end
    if emergency
      symptoms << {name: "emergency", color: "#78CEBD"}
    end
    if notes != nil && !notes.empty?
      symptoms << {name: "notes", color: "#BDF7B7"}
    end
    return symptoms
  end
end
