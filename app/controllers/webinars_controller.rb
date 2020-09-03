class WebinarsController < ApplicationController
  before_action :set_webinar, only: [:show]

  def index
    @webinars = policy_scope(Webinar)
  end

  def create
    @webinar = Webinar.new(webinar_params)
    authorize @webinar

    if @webinar.save
      redirect_to webinar_path(@webinar)
    else
      render :new
    end
  end

  def show
    authorize @webinar
  end

  private

  def set_webinar
    @webinar = Webinar.find(params[:id])
  end

  def webinar_params
    params.require(:webinar).permit(:title, :speaker_picture, :description, :speaker_name, :category, :start_at)
  end
end
