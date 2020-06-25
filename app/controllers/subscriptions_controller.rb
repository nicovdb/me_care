class SubscriptionsController < ApplicationController
  def create
    @user = current_user
    @stripe_token = params[:stripeToken]

    # check si customer existe déjà dans stripe, sinon on le crée
    customer = find_or_create_stripe_customer

    # Create the stripe subscription
    stripe_subscription = Stripe::Subscription.create(
      customer: customer,
      items: [
        {
          price: params[:price_stripe_id]
        }
      ]
    )

    # Create subscription in DB
    @subscription = Subscription.new(user: @user, price_id: params[:price_id].to_i, stripe_id: stripe_subscription.id, start_date: Time.at(stripe_subscription.start_date) )
    authorize @subscription
    @subscription.save
  end

  private

  def find_or_create_stripe_customer
    if @user.stripe_id?
      customer = Stripe::Customer.retrieve(@user.stripe_id)
      customer.source = @stripe_token
      customer.save
    else
      customer = Stripe::Customer.create(
        email: @user.email,
        source: @stripe_token
      )
      @user.update(stripe_id: customer.id)
    end
    customer
  end
end
