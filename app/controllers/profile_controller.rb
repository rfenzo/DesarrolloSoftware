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

  def my_sponsored_projects
  end

  def my_offered_benefits
  end

  def find_sponsor
    @companies = User.where(user_type: 'Company')
    @project = Project.find(params[:project_id])
  end

  private

  def validate_user
    unless current_user
      flash[:error] = t(:sign_in, scope: %i[flash profile error])
      redirect_to :new_user_session
    end
  end
end
