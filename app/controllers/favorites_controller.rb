class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user: current_user)
    authorize @favorite

    if params[:article].present?
      article = Article.find(params[:article])
      @favorite.article = article
      @favorite.save
      redirect_to article_path(article)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @favorite.destroy

    if !@favorite.article.nil?
      redirect_to article_path(@favorite.article)
    end
  end
end
