class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :symantec_auth, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  require "soteria"
  include SymantecAuthHelper

  protected

  def soteria
    Soteria.client(Rails.root.join("publicCert.pem"), Rails.root.join("privateKey.pem"), "TeamSymantec1234", true)
  end

  def symantec_auth
  	redirect_to symantec_auth_new_path unless second_auth_user_id
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :pin])
  end

end
