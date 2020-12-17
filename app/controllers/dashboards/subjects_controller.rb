class Dashboards::SubjectsController < ApplicationController

  def new
    @subject = Subject.new
    authorize @subject
  end

  def edit
    @subject = Subject.find(params[:id])
    authorize @subject
  end
end
