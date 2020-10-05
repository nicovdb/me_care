class DashboardsController < ApplicationController
  def show
    authorize :dashboard
    @articles = policy_scope(Article)
    @webinars = policy_scope(Webinar)
    @infoendos = policy_scope(Infoendo)
    @coupons = policy_scope(Coupon)
  end
end
