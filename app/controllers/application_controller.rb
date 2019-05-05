class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :isDonor?, :isCompany?, :isSocialCompany?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
  end

  def isDonor?
    return true if current_user and current_user.user_type == 'Donor' else false
  end

  def isCompany?
    return true if current_user and current_user.user_type == 'Company' else false
  end

  def isSocialCompany?
    return true if current_user and current_user.user_type == 'SocialCompany' else false
  end
end
