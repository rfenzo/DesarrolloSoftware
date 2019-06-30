# frozen_string_literal: true

class BenefitsController < ApplicationController
  load_and_authorize_resource
  before_action :set_profile_variables
  before_action :set_benefit, only: %i[show edit update destroy]

  # GET /benefits/1
  def show
  end

  # GET /benefits/new
  def new
    @benefit = Benefit.new
  end

  # GET /benefits/1/edit
  def edit
  end

  # POST /benefits
  def create
    @benefit = current_user.offered_benefits.new(benefit_params)

    if @benefit.save
      redirect_to :offered_benefits, flash: { success: t(:create,
                                                         scope: %i[flash benefit success]) }
    else
      render :new, flash: { error: t(:new, scope: %i[flash benefit error]) }
    end
  end

  # PATCH/PUT /benefits/1
  def update
    if @benefit.update(benefit_params)
      redirect_to :offered_benefits, flash: { success: t(:edit, scope: %i[flash benefit success]) }
    else
      render :edit, flash: { error: t(:edit, scope: %i[flash benefit error]) }
    end
  end

  # DELETE /benefits/1
  def destroy
    @benefit.destroy
    redirect_to :offered_benefits, flash: { success: t(:destroy, scope: %i[flash benefit success]) }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_benefit
    @benefit = Benefit.find_by(id: params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def benefit_params
    params.require(:benefit).permit(:title, :description)
  end
end
