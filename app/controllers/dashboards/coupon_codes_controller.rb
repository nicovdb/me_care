class Dashboards::CouponCodesController < ApplicationController

  def new
    @coupon_code = CouponCode.new
    authorize @coupon_code
  end

  def index
    @coupon_codes = policy_scope(CouponCode)
  end

  private

  def set_article
  end
end
