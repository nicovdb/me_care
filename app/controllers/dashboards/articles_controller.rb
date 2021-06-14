class Dashboards::ArticlesController < ApplicationController
  before_action :set_article, only: [:edit]

  def new
    @article = Article.new
    authorize @article
  end

  def edit
    authorize @article
  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end
end
