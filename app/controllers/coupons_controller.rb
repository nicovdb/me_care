class CouponsController < ApplicationController
  include ProductsAndSessions

  def use
    user_promotion_code = params[:coupon][:code]
    authorize(:coupon, :use?)
    if user_promotion_code == ""
      define_prices_and_sessions
      @errors = "Ce coupon n'existe pas"
      render 'pages/products'
    else
      promotion_code_data = Stripe::PromotionCode::list(code: user_promotion_code).data
      if promotion_code_data.empty?
        define_prices_and_sessions
        @errors = "Ce coupon n'existe pas"
        render 'pages/products'
      elsif promotion_code_data.first['active'] == false
        define_prices_and_sessions
        @errors = "Ce coupon a déjà été utilisé"
        render 'pages/products'
      else
        if current_user.subscription.stripe_id
          subscription_id = current_user.subscription.stripe_id
          promotion_code_id = promotion_code_data.first['id']
          stripe_subscription = Stripe::Subscription.retrieve(subscription_id)
          stripe_subscription.promotion_code = promotion_code_id
          stripe_subscription.save
        else
          coupon_id = promotion_code_data.first['coupon']['id']
          stripe_subscription = Stripe::Subscription.create(customer: current_user.stripe_id, plan:"price_1HaHgsBCt2fCpZSzwn5xhsaC", coupon: coupon_id)
          promotion_code_id = promotion_code_data.first['id']
          stripe_subscription.promotion_code = promotion_code_id
          stripe_subscription.save
          # promotion_code_data.first["active"] = false
          # promotion_code_data.first.save
        end
        free_months = promotion_code_data.first['coupon']['duration_in_months']
        old_end_date = current_user.subscription.end_date
        subscription = current_user.subscription.update(end_date: old_end_date + free_months.month, status: "active")
        flash[:notice] = "Vous avez été créditée de #{free_months} mois gratuits"
        redirect_to root_path
      end
    end
  end

  private

  def define_prices_and_sessions
    prices = [
      { name: "3 mois", price: "15€", id: "price_1HaHgsBCt2fCpZSzwn5xhsaC" },
      { name: "6 mois", price: "25€", id: "price_1HaHgfBCt2fCpZSzZugBICm9" },
      { name: "1 an", price: "50€", id: "price_1HZXuuBCt2fCpZSzJRp7SKnq" }
    ]

    @prices_and_sessions = prices.map do |price|
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price: price[:id],
          quantity: 1
        }],
        mode: 'subscription',
        success_url: profil_url,
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
