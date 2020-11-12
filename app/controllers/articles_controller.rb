class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @articles = policy_scope(Article).includes([:cover_attachment]).search_by_content_and_title_and_author(params[:query]).paginate(page: params[:page], per_page: 8).order(publication_date: :desc)
    elsif params[:category].present?
      @articles = policy_scope(Article).includes([:cover_attachment]).where(category: params[:category]).paginate(page: params[:page], per_page: 8).order(publication_date: :desc)
    elsif params[:media_type].present?
      @articles = policy_scope(Article).includes([:cover_attachment]).where(media_type: params[:media_type]).paginate(page: params[:page], per_page: 8).order(publication_date: :desc)
    else
      @articles = policy_scope(Article).includes([:cover_attachment]).paginate(page: params[:page], per_page: 8).order(publication_date: :desc)
    end
  end

  def show
    authorize @article
    @favorite = current_user.favorites.find_by(article: @article)
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
end
