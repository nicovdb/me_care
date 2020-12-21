class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @subject = Subject.find(params[:subject_id])
    @answer.subject = @subject
    authorize @answer
    if @answer.save
      page = (@subject.answers.count / 10.to_f).ceil
      redirect_to subject_path(@subject, anchor: "answer-#{@answer.id}", page: page)
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
