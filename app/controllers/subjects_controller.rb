class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @subjects = policy_scope(Subject)
                .includes([:forum_category, :answers])
                .order(created_at: :desc)
                .paginate(page: params[:page], per_page: 12)
    unless params[:forum_category].nil? || (params[:forum_category] == "")
      forum_category = ForumCategory.find_by(name: params[:forum_category])
      @subjects = @subjects.where(forum_category: forum_category)
    end
  end

  def show
    authorize @subject
    unless FollowSubject.find_by(user: current_user, subject: @subject).nil?
      @follow = FollowSubject.find_by(user: current_user, subject: @subject)
      @follow.seen = true
      @follow.save
    end
    @answer = Answer.new
    @follow_subject = FollowSubject.new
    @answers = @subject.answers
                       .includes([:user, :rich_text_content])
                       .order(created_at: :asc)
                       .paginate(page: params[:page], per_page: 10)
  end

  def new
    @subject = Subject.new
    authorize @subject
  end

  def create
    @subject = Subject.new(subject_params)
    authorize @subject
    @subject.user = current_user
    if current_user.admin?
      if @subject.save
        redirect_to dashboard_path(active: 'forum')
      else
        render 'dashboards/subjects/new'
      end
    else
      if @subject.save
        redirect_to subject_path(@subject)
      else
        render 'subjects/new'
      end
    end
  end

  def edit
    authorize @subject
  end

  def update
    authorize @subject
    if current_user.admin?
      if @subject.update(subject_params)
        redirect_to subject_path(@subject)
      else
        render 'dashboards/subjects/edit'
      end
    else
      if @subject.update(subject_params)
        redirect_to subject_path(@subject)
      else
        render 'subjects/edit'
      end
    end
  end

  def destroy
    authorize @subject
    @subject.destroy
    redirect_to forum_path
  end

  private

  def subject_params
    params.require(:subject).permit(:content, :title, :forum_category_id, :forum_category)
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end
end
