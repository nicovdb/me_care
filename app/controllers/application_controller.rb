class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  after_action :set_cookie
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :pseudo])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :pseudo])
  end

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas abonnée à cette fonctionnalité."
    redirect_to(products_path)
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale,
      host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || (params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ && action_name != "algorythm") || controller_name == 'moderation'|| controller_name == 'preferences' || controller_name == 'messageboard_groups'
  end

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def set_cookie
    unless cookies[:displayed_consent]
      cookies[:displayed_consent] = {
        value: 'true'
      }
    end
  end
end
