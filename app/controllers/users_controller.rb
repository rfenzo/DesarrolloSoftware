# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_profile_variables

  def dashboard
    authorize! :dashboard, current_user
  end

  def personal_info
    authorize! :personal_info, current_user
  end

  def donations
    authorize! :donations, current_user
    @donations = current_user.donations.reverse
    current_user.calculate_donations
  end

  def earned_benefits
    authorize! :earned_benefits, current_user
    @benefits = current_user.earned_benefits
    @benefits.map { |b| b.define_coupon_code(user: current_user) }
  end

  def social_projects
    authorize! :social_projects, current_user
    @projects = current_user.projects
    @projects.map(&:calculate_donations)
  end

  def contracts
    authorize! :contracts, current_user
    @contracts = current_user.contracts
  end

  def new_contract
    authorize! :new_contract, current_user
    @contract = Contract.new
    @benefits = current_user.offered_benefits
    @selected = params[:id]
  end

  def offered_benefits
    authorize! :offered_benefits, current_user
    @benefits = current_user.offered_benefits
  end

  def find_sponsor
    authorize! :find_sponsor, current_user
    @companies = User.where(user_type: 'Company')
    @project = Project.find_by(id: params[:project_id])
  end

  def requirements
    authorize! :requirements, current_user
    req = current_user.requirements if company?
    req = current_user.projects.map(&:requirements).first if social_company?
    @requirements = req
  end
end
