class Dashboards::SubjectsController < ApplicationController

  def new
    @subject = Subject.new
    authorize @subject
  end

  def edit
    @subject = Subject.find(params[:id])
    authorize @subject
  end

  def destroy
    @subject = Subject.find(params[:id])
    authorize @subject
    @subject.destroy
    redirect_to dashboard_path(active: 'forum')
  end
end
