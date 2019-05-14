class RequirementsController < ApplicationController
  before_action :requirement_params, only: [:create, :destroy]

  def create
    unless isSocialCompany?
      flash[:error] = t(:sign_in, scope: %i[flash require error])
      redirect_to :new_user_session
    else
      requirement = Requirement.new(requirement_params)
      if requirement.save
        flash[:success] = t(:default,
           scope: %i[flash require success],
           project: requirement.project.name,
           company: requirement.user.name
        )
        redirect_to my_social_projects_path
      else
        flash[:error] = t(:default, scope: %i[flash require error])
        redirect_to my_social_projects_path
      end
    end
  end

  def destroy
    unless isCompany?
      flash[:error] = t(:sign_in, scope: %i[flash require error])
      redirect_to :new_user_session
    else
      requirement = Requirement.find_by(requirement_params)
      requirement.destroy
      flash[:success] = t(:destroy,
        scope: %i[flash require success],
        project: requirement.project.name
      )
      redirect_to :my_requirements
    end
  end

  private

  def requirement_params
    params.require(:requirement).permit(:project_id, :user_id)
  end
end
