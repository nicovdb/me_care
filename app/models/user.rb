class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email, :set_stripe_customer, :set_trial
  after_create :send_to_mailchimp if Rails.env.production?
  has_many :subscriptions, dependent: :destroy
  has_one :plan, through: :subscription
  has_one :information
  has_many :favorites, dependent: :destroy
  has_many :webinar_subscriptions, dependent: :destroy
  has_many :webinars, through: :webinar_subscriptions
  has_one_attached :avatar
  validate :password_complexity
  validates :first_name, :last_name, :email, :password, presence: true

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

  private

  def send_to_mailchimp
    Zapier::UserCreated.new(self).post_to_zapier
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def set_stripe_customer
    customer = Stripe::Customer.create
    self.update_attributes(stripe_id: customer.id)
  end

  def set_trial
    price = Price.find_by(unit_amount: 0)
    subscription = Subscription.new(user: self, price: price, start_date: Date.today, end_date: Date.today + 15, status: "active")
    subscription.save
  end
end
