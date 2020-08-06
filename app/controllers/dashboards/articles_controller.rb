class Dashboards::ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy]

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

  def edit
    authorize @article
  end

  def update
    authorize @article
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    article_params = params.require(:article).permit(:title, :cover, :content, :author, :media_type, :category, :reading_time, :cover_credit)
    article_params
  end
end
