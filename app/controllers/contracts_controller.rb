# frozen_string_literal: true

class ContractsController < ApplicationController
  before_action do
    validate_user(t(:sign_in, scope: %i[flash contract error]))
  end
  before_action :validate_user_type
  before_action :contract_params, only: [:create]
  before_action :set_contract, only: [:destroy]

  def create
    contract = Contract.new(contract_params)
    if contract.save
      flash[:success] = t(:default,
                          scope:   %i[flash contract success],
                          project: contract.project.name,
                          benefit: contract.benefit.title)
      Requirement.find_by(project_id: contract.project.id, user_id: current_user.id).destroy
      redirect_to my_contracts_path
    else
      flash[:error] = t(:default, scope: %i[flash contract error])
      redirect_to my_requirements_path
    end
  end

  def destroy
    @contract.destroy
    flash[:success] = t(:destroy,
                        scope:    %i[flash contract success],
                        project:  @contract.project,
                        contract: @contract.benefit)
    redirect_to :my_contracts
  end

  private

  def contract_params
    params.require(:contract).permit(:project_id, :benefit_id)
  end

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def validate_user_type
    return if company?

    flash[:error] = t(:user_type, scope: %i[flash contract error])
    redirect_to root_path
  end
end
