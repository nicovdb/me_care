class WebinarsController < ApplicationController
  before_action :set_webinar, only: [:show, :edit, :update, :destroy]

  def index
    @webinars = policy_scope(Webinar).includes([:speaker_picture_attachment]).order(start_at: :desc)
  end

  def create
    @webinar = Webinar.new(webinar_params)
    @webinar.price = 5
    authorize @webinar

    if @webinar.save
      redirect_to webinar_path(@webinar)
    else
      render 'dashboards/webinars/new'
    end
  end

  def show
    authorize @webinar
    @webinar_subscription = current_user.webinar_subscriptions.find_by(webinar: @webinar)

    unless @webinar_subscription || current_user.has_valid_subscription?
      session = Stripe::Checkout::Session.create(
        customer: current_user.stripe_id,
        payment_method_types: ['card'],
        line_items: [{
          name: @webinar.title,
          amount: @webinar.price_cents,
          currency: 'eur',
          quantity: 1
        }],
        success_url: webinar_url(@webinar),
        cancel_url: webinar_url(@webinar)
      )
      @checkout_session_id = session.id
    end
  end

  def update
    authorize @webinar
    if @webinar.update(webinar_params)
      redirect_to webinar_path(@webinar)
    else
      render 'dashboards/webinars/edit'
    end
  end

  def destroy
    authorize @webinar
    @webinar.destroy
    redirect_to dashboard_path
  end

  private

  def set_webinar
    @webinar = Webinar.find(params[:id])
  end

  def webinar_params
    params.require(:webinar).permit(:title, :speaker_picture, :description, :speaker_name, :category, :start_at)
  end
end
