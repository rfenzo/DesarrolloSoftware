# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :donor?, :company?, :social_company?,
                :set_ranking_variables, :set_profile_variables,
                :validate_user

  protected

  def validate_user(message)
    return if current_user

    flash[:error] = message
    redirect_to :new_user_session
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
    return false unless current_user

    current_user.user_type == 'Donor'
  end

  def company?
    return false unless current_user

    current_user.user_type == 'Company'
  end

  def social_company?
    return false unless current_user

    current_user.user_type == 'SocialCompany'
  end
end
