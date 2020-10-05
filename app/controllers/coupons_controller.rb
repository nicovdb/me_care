class CouponsController < ApplicationController
  include ProductsAndSessions

  def create
    @coupon = Coupon.new(coupon_params)
    authorize @coupon

    if @coupon.save
      redirect_to dashboard_path(anchor: "coupons")
    else
      render 'dashboards/coupons/new'
    end
  end

  def use
    @coupon = Coupon.find_by(code: params[:coupon][:code])
    authorize(:coupon, :use?)
    if @coupon.nil?
      define_products_and_sessions
      @errors = "Ce coupon n'existe pas"
      render 'products/index'

    elsif @coupon.used?
      define_products_and_sessions
      @errors = "Ce coupon a déjà été utilisé"
      render 'products/index'
    else
      free_days = @coupon.free_days
      price = Price.find_by(unit_amount: 0)
      subscription = Subscription.new(user: current_user, price: price, start_date: Date.today, end_date: Date.today + free_days, status: "active")
      subscription.save

      @coupon.update(used: true, user: current_user)

      flash[:notice] = "Vous avez été créditée de #{free_days} jours gratuits"
      redirect_to root_path
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:free_days, :code)
  end
end
