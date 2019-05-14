class RequirementsController < ApplicationController
  def create
    unless current_user
      flash[:error] = t(:sign_in, scope: %i[flash require error])
      redirect_to :new_user_session
    else
      company = User.find(params[:company_id])
      project = Project.find(params[:project_id])
      requirement = Requirement.new({project: project, user: company})
      if requirement.save
        flash[:success] = t(:default, scope: %i[flash require success], project: project.name, company: company.name)
        redirect_to my_social_projects_path
      else
        flash[:error] = t(:default, scope: %i[flash require error])
        redirect_to my_social_projects_path
      end
    end
  end
end
