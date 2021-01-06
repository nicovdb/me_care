class UsersController < ApplicationController
  before_action :set_user, only: [:anonymize, :edit, :update]

  def show
    @user = current_user
    @subscription = @user.subscription
    authorize @user
    calculate_profile_completion
    @favorites = @user.favorites.includes([:infoendo, :article]).order(created_at: :desc)
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to profil_path
    else
      render 'edit'
    end
  end

  def forum_consent
    @user = User.find(params[:id])
    @user.forum_consent = true
    authorize @user
    if @user.save
      redirect_to forum_path
    else
      flash[:alert] = "Une erreur est survenue, contactez-nous."
      redirect_to root_path
    end
  end

  def anonymize
    @user.email = "#{@user.id}@email.com"
    @user.first_name = "Account deleted"
    @user.last_name = "Account deleted"
    @user.save
    authorize @user
    sign_out
    flash[:alert] = "Votre compte a bien été supprimé."
    redirect_to root_path
  end

  private

  def calculate_profile_completion
    profil_completion = 10
    if @user.avatar.attached?
      profil_completion += 10
    end
    if @user.information
      if !@user.information.date_of_birth.nil?
        profil_completion += 5.5
      end
      if !@user.information.family_situation.nil?
        profil_completion += 5.5
      end
      if @user.information.job != "" && @user.information.job != nil
        profil_completion += 5.5
      end
      if !@user.information.diagnosis_age.nil?
        profil_completion += 5.5
      end
      if !@user.information.imc.nil?
        profil_completion += 5.5
      end
      if !@user.information.family_antecedent.nil?
        profil_completion += 5.5
      end
      if !@user.information.children.nil?
        profil_completion += 5.5
      end
      if !@user.information.abortion.nil?
        profil_completion += 5.5
      end
      if !@user.information.pma.nil?
        profil_completion += 5.5
      end
      if !@user.information.endo_surgery.nil?
        profil_completion += 5.5
      end
      if !@user.information.pain_center.nil?
        profil_completion += 5
      end
      if !@user.information.physiotherapist.nil?
        profil_completion += 5
      end
      if !@user.information.ostheopath.nil?
        profil_completion += 5
      end
      if !@user.information.auto_immune_antecedent.nil?
        profil_completion += 5
      end
      if !@user.information.alternative_therapy.nil?
        profil_completion += 5
      end
    end
    @profil_completion_round = profil_completion.round
    @profil_completion_round
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :email, :pseudo)
  end
end
