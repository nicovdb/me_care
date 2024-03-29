class DashboardsController < ApplicationController
  def show
    authorize :dashboard
    @subjects = Subject.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @forum_categories = ForumCategory.all.order(created_at: :desc)
    @articles = Article.all.order(publication_date: :desc)
    @webinars = policy_scope(Webinar).order(start_at: :desc)
    @infoendos = Infoendo.all.order(publication_date: :desc)
    @admins = User.where(admin: true)
    @non_admins = User.where(admin:false, active: true)
    @all_users = User.all.order(created_at: :desc)
  end

  def publish_article
    @article = Article.find(params[:id])
    authorize(:article, :edit?)
    @article.published = true
    @article.save
    redirect_to dashboard_path
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
    redirect_to dashboard_path(active: 'infoendo')
  end

  def unpublish_infoendo
    @infoendo = Infoendo.find(params[:id])
    authorize(:infoendo, :edit?)
    @infoendo.published = false
    @infoendo.save
    redirect_to dashboard_path(active: 'infoendo')
  end

  def publish_webinar
    @webinar = Webinar.find(params[:id])
    authorize(:webinar, :edit?)
    @webinar.published = true
    @webinar.save
    redirect_to dashboard_path(active: 'webinar')
  end

  def unpublish_webinar
    @webinar = Webinar.find(params[:id])
    authorize(:webinar, :edit?)
    @webinar.published = false
    @webinar.save
    redirect_to dashboard_path(active: 'webinar')
  end
end
