class Dashboards::CouponsController < ApplicationController
  def new
    @coupon = Coupon.new
    authorize @coupon
  end
end
