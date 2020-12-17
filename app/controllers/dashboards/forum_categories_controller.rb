class Dashboards::ForumCategoriesController < ApplicationController

  def new
    @forum_category = ForumCategory.new
    authorize @forum_category
  end

  def edit
    @forum_category = ForumCategory.find(params[:id])
    authorize @forum_category
  end
end
