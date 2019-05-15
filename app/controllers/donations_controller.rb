class DonationsController < ApplicationController
  before_action :validate_user

  def donate
    amount = 1000
    @project = Project.find(params[:id])
    @donation = Donation.new(amount: amount, project: @project, user: current_user)
    if @donation.save
      flash[:success] = t(:default, scope: %i[flash donation success], project: @project.name, amount: amount)
      redirect_back fallback_location: root_path
    else
      flash[:error] = t(:default, scope: %i[flash donation error])
      redirect_to :projects
    end
  end

  private

  def validate_user
    unless isDonor? || isCompany?
      unless current_user
        flash[:error] = t(:sign_in, scope: %i[flash donation error])
        redirect_to :new_user_session
        return
      end
      flash[:error] = t(:user_type, scope: %i[flash donation error])
      redirect_to :projects
    end
  end
end
