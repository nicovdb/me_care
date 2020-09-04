class WebinarSubscription < ApplicationRecord
  belongs_to :webinar
  belongs_to :user

  validates :webinar_id, uniqueness: { scope: :user_id,
    message: "Vous êtes déjà inscrite à ce webinar" }
end
