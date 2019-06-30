# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :set_profile_variables

  def index
  end

  def personal_info
  end

  def donations
    p :ffssfdf
    p :ffssfdf
    p current_user.donations
    p :ffssfdf
    p :ffssfdf
    p :ffssfdf
    @donations = current_user.donations.reverse
    current_user.calculate_donations
  end

  def earned_benefits
    @benefits = current_user.earned_benefits
    @benefits.map { |b| b.define_coupon_code(user: current_user) }
  end

  def social_projects
    @projects = current_user.projects
    @projects.map(&:calculate_donations)
  end

  def contracts
    @contracts = current_user.contracts
  end

  def new_contract
    @contract = Contract.new
    @benefits = current_user.offered_benefits
    @selected = params[:id]
  end

  def offered_benefits
    @benefits = current_user.offered_benefits
  end

  def find_sponsor
    @companies = User.where(user_type: 'Company')
    @project = Project.find_by(id: params[:project_id])
  end

  def requirements
    authorize! :read, Requirement
    req = current_user.requirements if company?
    req = current_user.projects.map(&:requirements).first if social_company?
    @requirements = req
  end
end
