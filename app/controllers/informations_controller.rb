class InformationsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @information = Information.new
    authorize @information
  end

  def create
    @user = User.find(params[:user_id])
    @information = Information.new(information_params)
    authorize @information
    @information.user = @user
    if @information.save
      redirect_to profil_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @information = Information.find(params[:id])
    authorize @information
  end

  def update
    @user = User.find(params[:user_id])
    @information = Information.find(params[:id])
    authorize @information
    if @information.update(information_params)
      redirect_to profil_path(@user)
    else
      render 'edit'
    end
  end

  def information_params
    params.require(:information).permit(:date_of_birth, :family_situation, :job, :diagnosis_age, :size, :weight, :imc, :family_antecedent, :children, :children_number, :abortion, :abortion_number, :pma, :endo_surgery, :endo_surgery_number, :pain_center, :physiotherapist, :ostheopath, :alternative_therapy, :terms_conditions)
  end
end
