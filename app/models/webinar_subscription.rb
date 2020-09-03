class WebinarSubscription < ApplicationRecord
  belongs_to :webinar
  belongs_to :user
end
