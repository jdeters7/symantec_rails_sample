class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :symantec_auth, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  include SymantecAuthHelper

  protected

  def symantec_auth
  	redirect_to symantec_auth_new_path unless second_auth_user_id
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

end
