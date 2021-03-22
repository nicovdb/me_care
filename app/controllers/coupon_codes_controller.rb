class CouponCodesController < ApplicationController

  def create
    @coupon_code = CouponCode.new(coupon_code_params)
    if @coupon_code.save
      redirect_to dashboards_coupon_codes_path
    else
      render 'dashboards/coupon_codes/new'
    end
    authorize @coupon_code
  end

  def use
    user_promotion_code = params[:coupon_code][:code]
    @coupon = CouponCode.find_by(code: user_promotion_code)
    authorize(:coupon_code, :use?)
    if user_promotion_code == ""
      define_prices_and_sessions
      @errors = "Veuillez rentrer un code"
      render 'pages/products'
    else
      if user_promotion_code.empty?
        define_prices_and_sessions
        @errors = "Ce coupon n'existe pas"
        render 'pages/products'
      elsif @coupon.used
        define_prices_and_sessions
        @errors = "Ce coupon a déjà été utilisé"
        render 'pages/products'
      else
        if current_user.subscription.stripe_id
          define_prices_and_sessions
          @errors = "Vous avez déjà un abonnement valide en cours"
          render 'pages/products'
        else
          old_end_date = current_user.subscription.end_date
          current_user.subscription.update(end_date: old_end_date + @coupon.free_months.month, status: "trial_coupon_code")
          current_user.subscription.save
          @coupon.used = true
          @coupon.save
          flash[:notice] = "Vous avez été créditée de #{@coupon.free_months} mois gratuits"
          redirect_to root_path
        end
      end
    end
  end

  private

  def coupon_code_params
    params.require(:coupon_code).permit(:code, :free_months)
  end

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
