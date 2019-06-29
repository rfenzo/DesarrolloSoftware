# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action do
    validate_user(t(:sign_in, scope: %i[flash profile error]))
  end
  before_action :validate_user_type
  before_action :set_profile_variables

  def index
  end

  def my_data
  end

  def my_donations
    @donations = current_user.donations.reverse
    @total_amount = @donations.sum(&:amount)
  end

  def my_benefits
  end

  def my_social_projects
    @projects = current_user.projects
    @amounts = []
    @projects.each do |p|
      @amounts[p.id] = p.donations.sum(&:amount)
    end
  end

  def my_contracts
    @contracts = current_user.contracts
  end

  def new_contract
    @contract = Contract.new
    @my_benefits = current_user.benefits
    @selected = params[:id]
  end

  def my_offered_benefits
  end

  def find_sponsor
    @companies = User.where(user_type: 'Company')
    @project = Project.find(params[:project_id])
  end

  def my_requirements
    @requirements = current_user.requirements
  end

  private

  def validate_user_type
    return if company?

    flash[:error] = t(:user_type, scope: %i[flash profile error])
    redirect_to root_path
  end
end
