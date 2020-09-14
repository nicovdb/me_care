class InfoendosController < ApplicationController
  before_action :set_infoendo, only: [:show, :edit, :update, :destroy]

  def index
    @infoendos = policy_scope(Infoendo).includes([:cover_attachment])
  end

  def show
    authorize @infoendo
    #@favorite = current_user.favorites.find_by(infoendo: @infoendo)
  end

  def create
    @infoendo = Infoendo.new(infoendo_params)
    authorize @infoendo

    @infoendo.user = current_user
    if @infoendo.save
      redirect_to infoendo_path(@infoendo)
    else
      render 'dashboards/infoendos/new'
    end
  end

  def update
    authorize @infoendo
    if @infoendo.update(infoendo_params)
      redirect_to infoendo_path(@infoendo)
    else
      render 'dashboards/infoendos/edit'
    end
  end

  def destroy
    authorize @infoendo
    @infoendo.destroy
    redirect_to dashboard_path
  end

  private

  def set_infoendo
    @infoendo = Infoendo.find(params[:id])
  end

  def infoendo_params
    params.require(:infoendo).permit(:title, :cover, :content, :media_type, :category, :reading_time, :cover_credit)
  end
end
