class Dashboards::InfoendosController < ApplicationController
  before_action :set_infoendo, only: [:edit]

  def new
    @infoendo = Infoendo.new
    authorize @infoendo
  end

  def edit
    authorize @infoendo
  end

  private

  def set_infoendo
    @infoendo = Infoendo.friendly.find(params[:id])
  end
end
