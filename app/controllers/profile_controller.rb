class ProfileController < ApplicationController
  before_action :validate_user
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
    unless isCompany?
      flash[:error] = 'no tienes permiso para ver las solicitudes de patrocinio(esto debe traducirse)'
      redirect_to root_path
    else
      @requirements = current_user.requirements
    end
  end

  private

  def validate_user
    unless current_user
      flash[:error] = t(:sign_in, scope: %i[flash profile error])
      redirect_to :new_user_session
    end
  end
end
