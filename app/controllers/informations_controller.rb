class InformationsController < ApplicationController

  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_information, only: [:edit, :update]

  def new
    @information = Information.new
    authorize @information
  end

  def create
    if information_params[:terms_conditions] == "0"
      @information = Information.new(information_params)
      authorize @information
      render 'new'
      flash[:alert] = "Vous devez accepter le traitement de vos données."
    else
      @information = Information.new(information_params)
      authorize @information
      @information.user = @user
      if @information.save
        redirect_to profil_path(@user)
      else
        render 'new'
      end
    end
  end

  def edit
    authorize @information
  end

  def update
    authorize @information
    if information_params[:terms_conditions] == "0"
      render 'edit'
      flash[:alert] = "Vous devez accepter le traitement de vos données."
    else
      delete_info_diseases
      delete_info_alternative_therapies
      delete_info_fam_member_antes
      if @information.update(information_params)
        redirect_to profil_path(@user)
      else
        render 'edit'
      end
    end
  end

  private

  def delete_info_diseases
    if params[:information][:auto_immune_antecedent] == 'false'
      @information.info_diseases.destroy_all
    end
  end

  def delete_info_alternative_therapies
    if params[:information][:alternative_therapy] == 'false'
      @information.info_alternative_therapies.destroy_all
    end
  end

  def delete_info_fam_member_antes
    if params[:information][:family_antecedent] == 'false'
      @information.info_fam_member_antes.destroy_all
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_information
    @information = Information.find(params[:id])
  end

  def information_params
    params.require(:information).permit(:auto_immune_antecedent, :date_of_birth, :family_situation, :job, :diagnosis_age, :size, :weight, :imc, :family_antecedent, :children, :children_number, :abortion, :abortion_number, :pma, :endo_surgery, :endo_surgery_number, :pain_center, :physiotherapist, :ostheopath, :alternative_therapy, :terms_conditions, :miscarriage, :miscarriage_number, {fam_member_ante_ids: [] }, {alternative_therapy_ids: [] }, {disease_ids: [] })
  end
end
