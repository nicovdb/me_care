class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @articles = policy_scope(Article).includes([:cover_attachment])

    dynamic_filters

    @articles = @articles.search_by_content_and_title_and_author(params[:query]) if params[:query].present?
    @articles = @articles.where(category: @categories) if (@categories != [] && @categories != "")
    @articles = @articles.where(media_type: @media_types) if (@media_types != [] && @media_types != "")

    @articles = @articles.paginate(page: params[:page], per_page: 8).order(publication_date: :desc)
  end

  def show
    authorize @article
    @favorite = current_user.favorites.find_by(article: @article) if current_user
  end

  def create
    @article = Article.new(article_params)
    authorize @article
    @article.user = current_user
    if @article.save
      redirect_after_create_or_update
    else
      render 'dashboards/articles/new'
    end
  end

  def update
    authorize @article
    if @article.update(article_params)
      redirect_after_create_or_update
    else
      render 'dashboards/articles/edit'
    end
  end

  def destroy
    authorize @article
    @article.destroy
    redirect_to dashboard_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :cover, :content, :publication_date, :author, :media_type, :category, :reading_time, :cover_credit)
  end

  def redirect_after_create_or_update
    if params[:commit] == "Enregistrer"
      redirect_to edit_dashboards_article_path(@article)
    else
      @article.update(published: true)
      redirect_to dashboard_path
    end
  end

  def dynamic_filters
    if params[:categories].present? && params[:categories] != ""
      @categories = params[:categories]
    else
      @categories = []
    end

    if params[:category].present?
      if @categories.include?(params[:category])
        @categories.delete(params[:category])
      else
        @categories << params[:category]
      end
    end

    if params[:media_types].present? && params[:media_types] != ""
      @media_types = params[:media_types]
    else
      @media_types = []
    end

    if params[:media_type].present?
      if @media_types.include?(params[:media_type])
        @media_types.delete(params[:media_type])
      else
        @media_types << params[:media_type]
      end
    end
  end
end
