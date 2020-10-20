class UsersController < ApplicationController
  before_action :set_user, only: [:anonymize, :edit, :update]

  def show
    @user = current_user
    authorize @user
    @favorites = @user.favorites.includes([:infoendo, :article])
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :email, :pseudo)
  end
end
