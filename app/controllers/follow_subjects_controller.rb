class FollowSubjectsController < ApplicationController
  before_action :set_subject

  def create
    @follow_subject = FollowSubject.new
    @follow_subject.user = current_user
    @follow_subject.subject = @subject
    @follow_subject.seen = true
    authorize @follow_subject
    if @follow_subject.save
      redirect_to subject_path(@subject)
    else
      @answers = @subject.answers
      render 'subjects/show'
      flash[:alert] = "Il y a eu une erreur, vous ne pouvez pas suivre ce sujet pour l'instant."
    end
  end

  def destroy
    @follow_subject = FollowSubject.find_by(user: current_user, subject: @subject)
    authorize @follow_subject
    @follow_subject.destroy
    redirect_to subject_path(@subject)
    flash[:notice] = "Vous ne suivez plus ce sujet, cliquez sur la cloche pour recevoir à nouveau une alerte quand de nouveaux commentaires sont ajoutés à ce sujet."

  end

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end


end
