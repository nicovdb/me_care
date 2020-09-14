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
    if params[:infoendo].present?
      infoendo = Infoendo.find(params[:infoendo])
      @favorite.infoendo = infoendo
      @favorite.save
      redirect_to infoendo_path(infoendo)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @favorite.destroy

    if !@favorite.article.nil?
      redirect_to article_path(@favorite.article)
    end
    if !@favorite.infoendo.nil?
      redirect_to infoendo_path(@favorite.infoendo)
    end
  end
end
