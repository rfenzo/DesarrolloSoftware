# frozen_string_literal: true

class DonationsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_user_type

  def donate
    amount = 1000
    @project = Project.find_by(id: params[:id])
    @donation = Donation.new(amount: amount, project: @project, user: current_user)
    if @donation.save
      flash[:success] = t(:default, scope: %i[flash donation success], project: @project.name,
                                    amount: amount)
      return redirect_back fallback_location: root_path
    else
      flash[:error] = t(:default, scope: %i[flash donation error])
      redirect_to :projects
    end
  end

  private

  def validate_user_type
    return if donor? || company?

    flash[:error] = t(:user_type, scope: %i[flash donation error])
    redirect_to :projects
  end
end
