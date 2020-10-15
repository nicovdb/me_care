class WebinarSubscription < ApplicationRecord
  belongs_to :webinar
  belongs_to :user
  monetize :amount_cents

  validates :webinar_id, uniqueness: { scope: :user_id,
    message: "Vous êtes déjà inscrite à ce webinar" }

  def paid?
    state == "paid"
  end

  def send_to_mailchimp
    Zapier::WebinarSubscription.new(self).post_to_zapier
  end

  def send_confirmation_email
    UserMailer.with(user: self.user, webinar: self.webinar).webinar_subscription_confirmed.deliver_now
  end
end
