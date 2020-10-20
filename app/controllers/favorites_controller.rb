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
    redirect_back fallback_location: root_path
  end
end
