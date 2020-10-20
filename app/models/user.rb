class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  after_create :set_stripe_customer, :set_trial
  after_create :send_to_mailchimp if Rails.env.production?
  after_update :send_welcome_email
  has_one :subscription, dependent: :destroy
  has_one :plan, through: :subscription
  has_one :information, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :webinar_subscriptions, dependent: :destroy
  has_many :webinars, through: :webinar_subscriptions
  has_one_attached :avatar
  validate :password_complexity
  validates :pseudo, uniqueness: true
  validates :first_name, :last_name, :pseudo, presence: true

  def profile_picture
    if avatar.attached?
      avatar.key
    else
      "avatar/avatar_default"
    end
  end

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
    errors.add :password, "Votre mot de passe n'est pas assez complexe, il doit contenir au minimum 8 caractères dont 1 caractère spécial, 1 majuscule, 1 chiffre"
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def unread_posts_count
    all_unread = self.thredded_topic_read_states.map do |topic|
      topic.unread_posts_count
    end
    all_unread.sum
  end

  def has_valid_subscription?
    subscription && subscription.end_date >= Date.today && (subscription.status == "active" || subscription.status == "trialing")
  end

  private

  def send_to_mailchimp
    Zapier::UserCreated.new(self).post_to_zapier
  end

  def send_welcome_email
    if saved_change_to_attribute?(:confirmed_at)
      UserMailer.with(user: self).welcome.deliver_now
    end
  end

  def set_stripe_customer
    customer = Stripe::Customer.create(email: self.email)
    self.update_attributes(stripe_id: customer.id)
  end

  def set_trial
    stripe_subscription = Stripe::Subscription.create(customer: self.stripe_id, "items[0][price]": ENV["STRIPE_TRIAL_PRICE_ID"], trial_period_days: 15)
    Subscription.create(user: self, start_date: Date.today, end_date: Date.today + 15, status: stripe_subscription.status, stripe_id: stripe_subscription.id)
  end
end
