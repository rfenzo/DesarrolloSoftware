class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, except: [:index, :show, :donate]

  # GET /projects
  def index
    @projects = Project.all
    @amounts = []
    @projects.each do |p|
      @amounts[p.id] = p.donations.sum(&:amount)
    end
  end

  # GET /projects/1
  def show
    @amount = @project.donations.sum(&:amount)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      flash[:success] = t(:create, scope: %i[flash project success], project: @project.name)
      redirect_to @project
    else
      flash[:error] = t(:new, scope: %i[flash project error])
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      flash[:success] = t(:edit, scope: %i[flash project success], project: @project.name)
      redirect_to @project
    else
      flash[:error] = t(:edit, scope: %i[flash project error])
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    flash[:success] = t(:destroy, scope: %i[flash project success], project: @project.name)
    redirect_to projects_url
  end

  def donate
    unless current_user
      flash[:error] = t(:sign_in, scope: %i[flash donation error])
      redirect_to :new_user_session
    else
      amount = 1000
      @project = Project.find(params[:project_id])
      @donation = Donation.new({amount: amount, project: @project, user: current_user})
      if @donation.save
        flash[:success] = t(:default, scope: %i[flash donation success], project: @project.name, amount: amount)
        redirect_to :projects
      else
        flash[:error] = t(:default, scope: %i[flash donation error])
        redirect_to :projects
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def validate_user
      unless isSocialCompany?
        flash[:error] = t(:unauthorized, scope: %i[flash project error], project: @project.name)
        redirect_to root_path
      end
    end
end