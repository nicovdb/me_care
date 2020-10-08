class CouponsController < ApplicationController
  include ProductsAndSessions

  def use
    user_promotion_code = params[:coupon][:code]
    promotion_code_data = Stripe::PromotionCode::list(code: user_promotion_code).data
    authorize(:coupon, :use?)
    if promotion_code_data.empty?
      define_products_and_sessions
      @errors = "Ce coupon n'existe pas"
      render 'pages/products'
    elsif promotion_code_data.first['active'] == false
      define_products_and_sessions
      @errors = "Ce coupon a déjà été utilisé"
      render 'pages/products'
    else
      subscription_id = current_user.subscription.stripe_id
      promotion_code_id = promotion_code_data.first['id']
      stripe_subscription = Stripe::Subscription.retrieve(subscription_id)
      stripe_subscription.promotion_code = promotion_code_id
      stripe_subscription.save
      free_months = promotion_code_data.first['coupon']['duration_in_months']
      old_end_date = current_user.subscription.end_date
      subscription = current_user.subscription.update(end_date: old_end_date + free_months.month, status: "active")
      flash[:notice] = "Vous avez été créditée de #{free_months} mois gratuits"
      redirect_to root_path
    end


    # if @coupon.nil?
    #   define_products_and_sessions
    #   @errors = "Ce coupon n'existe pas"
    #   render 'products/index'

    # elsif @coupon.used?
    #   define_products_and_sessions
    #   @errors = "Ce coupon a déjà été utilisé"
    #   render 'products/index'
    # else
    #   free_days = @coupon.free_days
    #   price = Price.find_by(unit_amount: 0)
    #   subscription = Subscription.new(user: current_user, price: price, start_date: Date.today, end_date: Date.today + free_days, status: "active")
    #   subscription.save

    #   @coupon.update(used: true, user: current_user)

    #   flash[:notice] = "Vous avez été créditée de #{free_days} jours gratuits"
    #   redirect_to root_path
    # end
  end
end
