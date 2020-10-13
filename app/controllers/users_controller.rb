class UsersController < ApplicationController
  before_action :set_user, only: :anonymize

  def show
    @user = current_user
    authorize @user
    @favorites = @user.favorites.includes([:infoendo, :article])
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
end
