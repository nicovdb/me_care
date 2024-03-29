class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  after_create :set_stripe_customer #, :set_trial
  after_create :send_to_mailchimp if Rails.env.production?
  after_update :send_welcome_email
  has_one :subscription, dependent: :destroy
  has_one :plan, through: :subscription
  has_one :information, dependent: :destroy
  has_many :daily_symptoms
  has_many :favorites, dependent: :destroy
  has_many :webinar_subscriptions, dependent: :destroy
  has_many :webinars, through: :webinar_subscriptions
  has_many :daily_symptoms, dependent: :destroy
  has_one_attached :avatar
  has_many :follow_subjects, dependent: :destroy
  has_many :subjects, through: :follow_subjects
  has_many :seen_articles, dependent: :destroy
  has_many :seen_infoendos, dependent: :destroy
  has_many :seen_webinars, dependent: :destroy
  validate :password_complexity
  validates :pseudo, uniqueness: true
  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/,
    message: "doit être composé de lettres uniquement" }
  validates :pseudo, presence: true
  def profile_picture
    if avatar.attached?
      avatar.key
    else
      "avatar/avatar_default"
    end
  end

  def profile_picture_green
    if avatar.attached?
      avatar.key
    else
      "avatar/avatar_default_green"
    end
  end

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?.!@$%^&*-_]).{8,70}$/
    errors.add :password, "Votre mot de passe n'est pas assez complexe, il doit contenir au minimum 8 caractères dont 1 caractère spécial, 1 majuscule, 1 chiffre"
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def notification_number
    follow_subjects.where(seen: false).count
  end

  def unseen_news_number
    seen_articles.where(seen: false).count
  end

  def unseen_infoendos_number
    seen_infoendos.where(seen: false).count
  end

  def unseen_webinars_number
    seen_webinars.where(seen: false).count
  end

  def has_valid_subscription?
    subscription && subscription.end_date >= Date.today && (subscription.status == "active" || subscription.status == "trialing" || subscription.status == "trial_coupon_code")
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

  # def set_trial
  #   Subscription.create(user: self, start_date: Date.today, end_date: Date.today + 15, status: "trialing")
  # end
end
