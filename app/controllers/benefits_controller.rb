class BenefitsController < ApplicationController
  before_action :set_benefit, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /benefits
  def index
    @benefits = Benefit.where(user_id: @user.id)
  end

  # GET /benefits/1
  def show
  end

  # GET /benefits/new
  def new
    @benefit = Benefit.new
    @users = User.all
  end

  # GET /benefits/1/edit
  def edit
  end

  # POST /benefits
  def create
    @benefit = Benefit.new(benefit_params)
    @benefit.user = @user

    if @benefit.save
      redirect_to user_benefits_url, notice: 'Benefit was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /benefits/1
  def update
    if @benefit.update(benefit_params)
      redirect_to @benefit, notice: 'Benefit was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /benefits/1
  def destroy
    @benefit.destroy
    redirect_to user_benefits_url, notice: 'Benefit was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benefit
      @benefit = Benefit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def benefit_params
      params.require(:benefit).permit(:title, :description, :user_id)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
