class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email, :set_stripe_customer, :set_trial
  has_many :subscriptions, dependent: :destroy
  has_one :plan, through: :subscription
  has_many :favorites, dependent: :destroy

  private

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
