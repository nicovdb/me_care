class CustomerPortalSessionsController < ApplicationController
  def create
    authorize(:customer_portal_session, :create?)
    portal_session = Stripe::BillingPortal::Session.create(
      customer: current_user.stripe_id,
      return_url: root_url
    )
    redirect_to portal_session.url
  end
end
