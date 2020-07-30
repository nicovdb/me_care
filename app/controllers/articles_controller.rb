class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article

    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def show
    authorize @article
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    article_params = params.require(:article).permit(:title, :content, :author, :media_type, :category, :reading_time, :cover_credit)

    article_params[:media_type] = article_params[:media_type].to_i
    article_params[:category] = article_params[:category].to_i

    article_params
  end
end
