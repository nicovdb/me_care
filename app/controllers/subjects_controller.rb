class SubjectsController < ApplicationController
  def index
    if params[:forum_category].nil? || (params[:forum_category] == "")
      @subjects = policy_scope(Subject).paginate(page: params[:page], per_page: 12).order(created_at: :desc)
    else
      forum_category = ForumCategory.find_by(name: params[:forum_category])
      @subjects = policy_scope(Subject).where(forum_category: forum_category).paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    end
  end

  def show
    @subject = Subject.find(params[:id])
    authorize @subject
    @answer = Answer.new
    @answers = @subject.answers.paginate(page: params[:page], per_page: 10).order(created_at: :asc)
  end

  def new
    @subject = Subject.new
    authorize @subject
  end

  def create
    @subject = Subject.new(subject_params)
    authorize @subject
    @subject.user = current_user
    if @subject.save
      redirect_to dashboard_path(active: 'forum')
    else
      render 'dashboards/subjects/new'
    end
  end

  def update
    @subject = Subject.find(params[:id])
    authorize @subject
    if @subject.update(subject_params)
      redirect_to subject_path(@subject)
    else
      render 'dashboards/subjects/edit'
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:content, :title, :forum_category_id, :forum_category)
  end
end
