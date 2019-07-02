# frozen_string_literal: true

class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :donor?, :company?, :social_company?,
                :set_ranking_variables, :set_profile_variables

  rescue_from CanCan::AccessDenied do |exception|
    message = 'No tienes permiso para acceder a ese recurso'
    if exception.subject.present?
      message = t(exception.action, scope: [:ability, exception.subject.class.name.downcase])
    end
    redirect_back fallback_location: :root, flash: { error: message }
  end

  protected

  def set_ranking_variables
    @render_ranking_bar = true
    @users = User.select { |u| u.user_type.in?(%w[Company Donor]) }
    @users.map(&:calculate_donations)
    @ranking = @users.sort_by{|c| c.total_donations}.reverse![0..4]
  end

  def set_profile_variables
    @render_profile_bar = true
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[
                                        user_type
                                        name
                                        rut
                                        validation
                                        compromise
                                        address
                                        description
                                        avatar
                                      ])
  end

  def donor?
    current_user&.user_type == 'Donor'
  end

  def company?
    current_user&.user_type == 'Company'
  end

  def social_company?
    current_user&.user_type == 'SocialCompany'
  end
end
