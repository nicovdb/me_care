class InformationsController < ApplicationController

  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_information, only: [:update, :destroy]

  def new
    @information = Information.new
    @information.diseases.build
    @information.alternative_therapies.build
    @displayed_diseases = Disease.where(displayed: true)
    @displayed_therapies = AlternativeTherapy.where(displayed: true)
    authorize @information
  end

  def create
    if information_params[:terms_conditions] == "0"
      @information = Information.new(information_params)
      authorize @information
      render 'new'
      flash[:alert] = "Vous devez accepter le traitement de vos données."
    else
      check_for_other_disease_and_therapy
      @information = Information.new(information_params)
      authorize @information
      @information.user = @user
      if @information.save
        redirect_to profil_path
      else
        render 'new'
      end
    end
  end

  def edit
    @information = Information.includes(:diseases, :alternative_therapies).find(params[:id])
    set_diseases_and_therapies
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
        redirect_to profil_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @user = @information.user
    authorize @information
    @information.destroy
    redirect_to profil_path
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
    params.require(:information).permit(:auto_immune_antecedent, :date_of_birth, :family_situation, :job, :diagnosis_age, :size, :weight, :imc, :family_antecedent, :children, :children_number, :abortion, :abortion_number, :pma, :endo_surgery, :endo_surgery_number, :pain_center, :physiotherapist, :ostheopath, :alternative_therapy, :terms_conditions, :miscarriage, :miscarriage_number, {fam_member_ante_ids: [] }, {alternative_therapy_ids: [] }, {disease_ids: [] }, diseases_attributes: [:name], alternative_therapies_attributes: [:name])
  end

  def check_for_other_disease_and_therapy
    params_diseases = params[:information].dig(:diseases_attributes, "0", "name")
    params_therapies = params[:information].dig(:alternative_therapies_attributes, "0", "name")
    if params_diseases&.empty?
      params[:information].delete :diseases_attributes
    end
    if params_therapies&.empty?
      params[:information].delete :alternative_therapies_attributes
    end
  end

  def set_diseases_and_therapies
    @displayed_diseases = Disease.where(displayed: true).to_a
    additional_diseases = @information.diseases.where(displayed: false)
    unless additional_diseases.empty? || additional_diseases.first.name.empty?
      @displayed_diseases << additional_diseases.first
    end

    @displayed_therapies = AlternativeTherapy.where(displayed: true).to_a
    additional_therapies = @information.alternative_therapies.where(displayed: false)
    unless additional_therapies.empty? || additional_therapies.first.name.empty?
      @displayed_therapies << additional_therapies.first
    end
  end
end
