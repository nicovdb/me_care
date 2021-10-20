# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }
  before_action :check_if_active, only: [:create]

  #after_action :check_trial_end_date, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  def check_if_active
    if User.find_by(email: params[:user][:email]) &&  User.find_by(email: params[:user][:email]).active == false
      flash[:alert] =  "Votre compte a été désactivé"
      redirect_to root_path
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
