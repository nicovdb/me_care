class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @subject = Subject.find(params[:subject_id])
    @answer.subject = @subject
    authorize @answer
    if @answer.save
      redirect_to subject_path(@subject)
    else
      render 'subject/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @subject = @answer.subject
    authorize @answer
    @answer.destroy
    redirect_to subject_path(@subject)
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
