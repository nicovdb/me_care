class InfoendosController < ApplicationController
  before_action :set_infoendo, only: [:show, :edit, :update, :destroy]

  def index
    @infoendos = policy_scope(Infoendo).includes([:cover_attachment])
    if params[:query].present?
      @videos = @infoendos.where(media_type: "video").search_by_content_and_title(params[:query]).order(publication_date: :desc)
      @articles = @infoendos.where(media_type: "article").search_by_content_and_title(params[:query]).order(publication_date: :desc)
    else
      @videos = @infoendos.where(media_type: "video").order(publication_date: :desc)
      @articles = @infoendos.where(media_type: "article").order(publication_date: :desc)
    end
  end

  def show
    authorize @infoendo
    @favorite = current_user.favorites.find_by(infoendo: @infoendo)
  end

  def create
    @infoendo = Infoendo.new(infoendo_params)
    authorize @infoendo

    @infoendo.user = current_user
    if @infoendo.save
      redirect_after_create_or_update
    else
      render 'dashboards/infoendos/new'
    end
  end

  def update
    authorize @infoendo
    if @infoendo.update(infoendo_params)
      redirect_after_create_or_update
    else
      render 'dashboards/infoendos/edit'
    end
  end

  def destroy
    authorize @infoendo
    @infoendo.destroy
    redirect_to dashboard_path(active: 'infoendo')
  end

  private

  def set_infoendo
    @infoendo = Infoendo.friendly.find(params[:id])
  end

  def infoendo_params
    params.require(:infoendo).permit(:title, :publication_date, :cover, :alt_text, :content, :media_type, :category, :reading_time, :cover_credit, :video)
  end

  def redirect_after_create_or_update
    if params[:commit] == "Enregistrer"
      redirect_to edit_dashboards_infoendo_path(@infoendo)
    else
      @infoendo.update(published: true)
      redirect_to dashboard_path(active: 'infoendo')
    end
  end
end
