require 'date'

class ApplicationController < ActionController::Base
  include Common
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :setting_model_column
  helper_method :setting_shared_column

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_id])
  end
end
