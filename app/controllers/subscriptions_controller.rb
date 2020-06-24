class SubscriptionsController < ApplicationController
  def create
    @user = current_user

    # check si customer existe déjà dans stripe, sinon on le crée
    customer = find_or_create_stripe_customer

    # create the subscription
    @subscription = Subscription.new(user: @user, price_id: params[:price_id].to_i)
    authorize @subscription

    stripe_subscription = Stripe::Subscription.create(
      customer: customer,
      items: [
        {
          price: @subscription.price.stripe_id
        }
      ]
    )

    @subscription.stripe_id = stripe_subscription.id
    @subscription.start_date = Time.at(stripe_subscription.start_date)
    @subscription.save!
    redirect_to root_path
  end

  private

  def find_or_create_stripe_customer
    if @user.stripe_id?
      customer = Stripe::Customer.retrieve(@user.stripe_id)
      # customer.source = @stripe_token
      # customer.save
    else
      customer = Stripe::Customer.create(
        email: @user.email
        # source: @stripe_token,
        # coupon: @coupon_code.presence
      )
      @user.update(stripe_id: customer.id)
    end
    customer
  end
end
