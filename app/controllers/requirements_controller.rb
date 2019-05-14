class RequirementsController < ApplicationController
  def create
    unless isSocialCompany?
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

  def destroy
    unless isCompany?
      flash[:error] = t(:sign_in, scope: %i[flash require error])
      redirect_to :new_user_session
    else
      requirement = Requirement.where({project_id: params[:project_id], user: params[:company_id]}).destroy
      requirement.destroy
      flash[:success] = t(:destroy, scope: %i[flash requirement success], requirement: requirement.project.name)
      redirect_to :my_requirements
    end
  end
end
