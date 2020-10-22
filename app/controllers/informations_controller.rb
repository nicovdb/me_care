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
    @information = Information.new(information_params)
    authorize @information
    if information_params[:terms_conditions] == "0"
      flash[:alert] = "Vous devez accepter le traitement de vos données."
      @anchor = "terms"
      render 'new'
    else
      @information.user = @user
      if @information.save
        flash[:alert] = nil
        redirect_to profil_path
      else
        render 'new'
      end
    end
  end

  def edit
    @information = Information.includes(:diseases, :alternative_therapies).find(params[:id])
    @displayed_diseases = Disease.where(displayed: true)
    @displayed_therapies = AlternativeTherapy.where(displayed: true)
    authorize @information
  end

  def update
    authorize @information
    if information_params[:terms_conditions] == "0"
      flash[:alert] = "Vous devez accepter le traitement de vos données."
      @anchor = "terms"
      render 'edit'
    else
      delete_infos
      delete_form_numbers
      if @information.update(information_params)
        flash[:alert] = nil
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

  def delete_infos
    if params[:information][:auto_immune_antecedent] == 'false'
      @information.info_diseases.destroy_all
      @information.other_disease = nil
    end
    if params[:information][:alternative_therapy] == 'false'
      @information.info_alternative_therapies.destroy_all
      @information.other_alternative_therapy = nil
    end
    if params[:information][:family_antecedent] == 'false'
      @information.info_fam_member_antes.destroy_all
    end
  end

  def delete_form_numbers
    if params[:information][:children] == 'false'
      @information.children_number = nil
    end
    if params[:information][:miscarriage] == 'false'
      @information.miscarriage_number = nil
    end
    if params[:information][:endo_surgery] == 'false'
      @information.endo_surgery_number = nil
    end
    if params[:information][:abortion] == 'false'
      @information.abortion_number = nil
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_information
    @information = Information.find(params[:id])
  end

  def information_params
    params.require(:information).permit(:auto_immune_antecedent, :date_of_birth, :family_situation, :job, :diagnosis_age, :size, :weight, :imc, :family_antecedent, :children, :children_number, :abortion, :abortion_number, :pma, :endo_surgery, :endo_surgery_number, :pain_center, :physiotherapist, :ostheopath, :alternative_therapy, :terms_conditions, :miscarriage, :miscarriage_number, :other_alternative_therapy, :other_disease, {fam_member_ante_ids: [] }, {alternative_therapy_ids: [] }, {disease_ids: [] }, diseases_attributes: [:name], alternative_therapies_attributes: [:name])
  end
end
