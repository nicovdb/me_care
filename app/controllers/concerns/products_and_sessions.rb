module ProductsAndSessions
  extend ActiveSupport::Concern

  included do
    helper_method :define_products_and_sessions
  end

  def define_products_and_sessions
    @products = policy_scope(Product).includes([:price])

    @products_and_sessions = @products.map do |product|
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price: "#{product.price.stripe_id}",
          quantity: 1,
        }],
        mode: 'subscription',
        success_url: root_url,
        cancel_url: products_url,
        client_reference_id: current_user.id,
        customer: find_or_create_stripe_customer_id
      })
      checkout_id = session.id

      {product: product, checkout_id: checkout_id}
    end
  end

  private

  def find_or_create_stripe_customer_id
    if current_user.stripe_id?
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
    else
      customer = Stripe::Customer.create(
        email: current_user.email
      )
      current_user.update(stripe_id: customer.id)
    end
    customer.id
  end
end
