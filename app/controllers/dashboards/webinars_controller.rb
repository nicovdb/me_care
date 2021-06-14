class Dashboards::WebinarsController < ApplicationController
  before_action :set_webinar, only: [:edit]

  def new
    @webinar = Webinar.new
    authorize @webinar
  end

  def edit
    authorize @webinar
  end

  private

  def set_webinar
    @webinar = Webinar.friendly.find(params[:id])
  end
end
