class ContractsController < ApplicationController
  before_action :contract_params, only: [:create, :destroy]

  def create
    unless isCompany?
      flash[:error] = t(:sign_in, scope: %i[flash require error])
      redirect_to :new_user_session
    else
      contract = Contract.new(contract_params)
      if contract.save
        flash[:success] = t(:default,
           scope: %i[flash contract success],
           project: contract.project.name,
           benefit: contract.benefit.title
        )
        redirect_to user_benefits_path(current_user)
      else
        flash[:error] = t(:default, scope: %i[flash require error])
        redirect_to user_benefits_path(current_user)
      end
    end
  end

  def destroy
    redirect_to root_path
    # unless isCompany?
    #   flash[:error] = t(:sign_in, scope: %i[flash require error])
    #   redirect_to :new_user_session
    # else
    #   requirement = Requirement.find_by(requirement_params)
    #   requirement.destroy
    #   flash[:success] = t(:destroy,
    #     scope: %i[flash require success],
    #     project: requirement.project.name
    #   )
    #   redirect_to :my_requirements
    # end
  end

  private

  def contract_params
    params.require(:contract).permit(:project_id, :benefit_id)
  end
end
