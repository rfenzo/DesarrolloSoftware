class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :isDonor?, :isCompany?, :isSocialCompany?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type, :name, :rut, :validation, :compromise, :address, :description])
  end

  def isDonor?
    if current_user and current_user.user_type == 'Donor'
      return true
    else
      return false
    end
  end

  def isCompany?
    if current_user and current_user.user_type == 'Company'
      return true
    else
      return false
    end
  end

  def isSocialCompany?
    if current_user and current_user.user_type == 'SocialCompany'
      return true
    else
      return false
    end
  end
end
