# frozen_string_literal: true

class ContractsController < ApplicationController
  load_and_authorize_resource
  before_action :contract_params, only: [:create]
  before_action :set_contract, only: [:destroy]

  def create
    if Contract.find_by(contract_params)
      return redirect_to :requirements, flash: { error: t(:duplicate,
                                                          scope: %i[flash contract error]) }
    end

    contract = Contract.new(contract_params)
    if contract.save
      Requirement.find_by(project_id: contract.project.id, user_id: current_user.id)&.destroy
      redirect_to :contracts, flash: { success: t(:default,
                                                  scope:   %i[flash contract success],
                                                  project: contract.project.name,
                                                  benefit: contract.benefit.title) }
    else
      redirect_to :requirements, flash: { error: t(:default, scope: %i[flash contract error]) }
    end
  end

  def destroy
    @contract.destroy
    flash[:success] = t(:destroy,
                        scope:    %i[flash contract success],
                        project:  @contract.project,
                        contract: @contract.benefit)
    redirect_to :contracts, flash: { success: t(:destroy,
                                                scope:    %i[flash contract success],
                                                project:  @contract.project,
                                                contract: @contract.benefit) }
  end

  private

  def contract_params
    params.require(:contract).permit(:project_id, :benefit_id)
  end

  def set_contract
    @contract = Contract.find_by(id: params[:id])
  end

  def validate_user_type
    return if company?

    flash[:error] = t(:user_type, scope: %i[flash contract error])
    redirect_to root_path
  end
end
