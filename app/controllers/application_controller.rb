class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_ranking_variables, if: :show_ranking?
  before_action :set_profile_variables, if: :show_profile?

  helper_method :isDonor?, :isCompany?, :isSocialCompany?

  protected

  def show_ranking?
    request.filtered_parameters["controller"].in?(['home','projects'])
  end

  def show_profile?
    request.filtered_parameters["controller"].in?(['profile', 'benefits'])
  end

  def set_ranking_variables
    @render_ranking_bar = true
    @companies = User.where(user_type: 'Company').limit(20)
    @sponsor_estimation = {}
    @donated = {}
    @companies.each do |c|
      @sponsor_estimation[c.id] = 0
      @donated[c.id] = c.donations.sum(&:amount)
    end
  end

  def set_profile_variables
    @render_profile_bar = true
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type, :name, :rut, :validation, :compromise, :address, :description, :avatar])
  end

  def isDonor?
    unless current_user
      return false
    end
    current_user.user_type == 'Donor'
  end

  def isCompany?
    unless current_user
      return false
    end
    current_user.user_type == 'Company'
  end

  def isSocialCompany?
    unless current_user
      return false
    end
    current_user.user_type == 'SocialCompany'
  end
end
