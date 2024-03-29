class PagesController < ApplicationController
  include ProductsAndSessions
  skip_before_action :authenticate_user!, only: [:home, :team, :legals]

  def home
  end

  def team
  end

  def legals
  end

  def charte_forum
  end

  def algorythm
    authorize(:page, :algorythm?)
  end

  def products
    define_prices_and_sessions
  end

  private

  def define_prices_and_sessions
    prices = [
      { name: "3 mois", price: "15€", id: ENV['PRICE_3_MONTHS'] },
      { name: "6 mois", price: "25€", id: ENV['PRICE_6_MONTHS'] },
      { name: "1 an", price: "50€", id: ENV['PRICE_12_MONTHS'] }
    ]

    @prices_and_sessions = prices.map do |price|
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price: price[:id],
          quantity: 1
        }],
        mode: 'subscription',
        success_url: ENV['SUCCESS_URL_STRIPE'],
        cancel_url: products_url,
        client_reference_id: current_user.id,
        customer: find_or_create_stripe_customer_id
      })
      checkout_id = session.id

      { name: price[:name], price: price[:price], checkout_id: checkout_id }
    end
  end

  def find_or_create_stripe_customer_id
    if !current_user.stripe_id?
      customer = Stripe::Customer.create(
        email: current_user.email
      )
      current_user.update(stripe_id: customer.id)
    end
    current_user.stripe_id
  end
end
