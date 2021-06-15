class WebinarsController < ApplicationController
  before_action :set_webinar, only: [:show, :edit, :update, :destroy]

  def index
    @webinars = policy_scope(Webinar).includes([:speaker_picture_attachment]).order(start_at: :desc)
  end

  def create
    @webinar = Webinar.new(webinar_params)
    authorize @webinar

    if @webinar.save
       User.all.each do |u|
        SeenWebinar.create(user: u, webinar: @webinar, seen: false)
      end
      redirect_after_create_or_update
    else
      render 'dashboards/webinars/new'
    end
  end

  def show
    authorize @webinar
    if current_user
      @seen_webinar = SeenWebinar.find_by(user: current_user, webinar: @webinar)
      if !@seen_webinar.nil? && @seen_webinar.seen == false
        @seen_webinar.seen = true
        @seen_webinar.save
      end
    end
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
      redirect_after_create_or_update
    else
      render 'dashboards/webinars/edit'
    end
  end

  def destroy
    authorize @webinar
    if @webinar.webinar_subscriptions.any?
      flash[:alert] = "Il y a des inscriptions à ce webinar, vous ne pouvez pas le supprimer."
    else
      @webinar.destroy
    end
    redirect_to dashboard_path(active: 'webinar')
  end

  private

  def set_webinar
    @webinar = Webinar.friendly.find(params[:id])
  end

  def webinar_params
    params.require(:webinar).permit(:title, :speaker_picture, :description, :speaker_name, :category, :start_at)
  end

  def redirect_after_create_or_update
    if params[:commit] == "Enregistrer"
      redirect_to edit_dashboards_webinar_path(@webinar)
    else
      @webinar.update(published: true)
      redirect_to dashboard_path(active: 'webinar')
    end
  end
end
