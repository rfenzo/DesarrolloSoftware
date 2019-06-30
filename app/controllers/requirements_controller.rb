# frozen_string_literal: true

class RequirementsController < ApplicationController

  before_action :requirement_params, only: [:create]
  before_action :set_requirement, only: [:destroy]

  def create
    authorize! :create, Requirement
    requirement = Requirement.new(requirement_params)
    if requirement.save
      flash[:success] = t(:default,
                          scope:   %i[flash require success],
                          project: requirement.project.name,
                          company: requirement.user.name)
    else
      flash[:error] = t(:default, scope: %i[flash require error])
    end
    p requirement
    redirect_to :social_projects
  end

  def destroy
    authorize! :destroy, @requirement
    @requirement.destroy
    redirect_to :requirements, flash: { success: t(:destroy,
                                                   scope:   %i[flash require success],
                                                   project: @requirement.project.name) }
  end

  private

  def requirement_params
    params.require(:requirement).permit(:project_id, :user_id)
  end

  def set_requirement
    @requirement = Requirement.find_by(id: params[:id])
  end
end
