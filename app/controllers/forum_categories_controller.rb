class ForumCategoriesController < ApplicationController
  def create
    @forum_category = ForumCategory.new(forum_category_params)
    authorize @forum_category
    if @forum_category.save
      redirect_to dashboard_path(active: 'forum')
    else
      render :new
    end
  end

  def update
    @forum_category = ForumCategory.find(params[:id])
    authorize @forum_category
    if @forum_category.update(forum_category_params)
      redirect_to dashboard_path(active: 'forum')
    else
      render :new
    end
  end

  private

  def forum_category_params
    params.require(:forum_category).permit(:name)
  end
end
