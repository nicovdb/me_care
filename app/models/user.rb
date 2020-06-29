class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email, :set_stripe_customer
  has_one :subscription, dependent: :destroy
  has_one :plan, through: :subscription

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def set_stripe_customer
    customer = Stripe::Customer.create
    self.update_attributes(stripe_id: customer.id)
  end
end
