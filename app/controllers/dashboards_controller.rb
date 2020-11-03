class DashboardsController < ApplicationController
  def show
    authorize :dashboard
    @articles = Article.all
    @webinars = policy_scope(Webinar)
    @infoendos = Infoendo.all
  end

  def publish_article
    @article = Article.find(params[:id])
    authorize(:article, :edit?)
    @article.published = true
    @article.save
    redirect_to article_path(@article)
  end

  def unpublish_article
    @article = Article.find(params[:id])
    authorize(:article, :edit?)
    @article.published = false
    @article.save
    redirect_to dashboard_path
  end

  def publish_infoendo
    @infoendo = Infoendo.find(params[:id])
    authorize(:infoendo, :edit?)
    @infoendo.published = true
    @infoendo.save
    redirect_to infoendo_path(@infoendo)
  end

  def unpublish_infoendo
    @infoendo = Infoendo.find(params[:id])
    authorize(:infoendo, :edit?)
    @infoendo.published = false
    @infoendo.save
    redirect_to dashboard_path
  end
end
