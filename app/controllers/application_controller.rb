class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permited_params, if: :devise_controller?

  protected
  def configure_permited_params
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :admin])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end
end
