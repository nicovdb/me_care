# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  #private

  # def check_trial_end_date
  #   if current_user.subscription
  #     product = current_user.subscription.product
  #     if product.name == "Trial" && current_user.subscription.end_date < Date.today
  #       current_user.subscription.destroy
  #       flash[:alert] = "Attention votre essai gratuit est terminé"
  #     end
  #   end
  # end
end
