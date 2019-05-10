class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, except: [:index, :show, :donate]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @amounts = []
    @projects.each do |p|
      @amounts[p.id] = p.donations.sum(&:amount)
    end
  end

  # GET /projects/1
  # GET /projects/1.json
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
  # POST /projects.json
  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def donate
    respond_to do |format|
      unless current_user
        format.html { redirect_to :new_user_session, notice: 'Debes registrarte para realizar donaciones' }
        format.json { render json: {error: 'texto del error'}, status: :unprocessable_entity }
      else
        amount = 1000
        @project = Project.find(params[:project_id])
        @donation = Donation.new({amount: amount, project: @project, user: current_user})
        if @donation.save
          format.html { redirect_to :projects, notice: "Realizaste correctamente una donación por #{amount} al proyecto '#{@project.name}'" }
          format.json { render :show, status: :ok, location: :projects }
        else
          format.html { redirect_to :projects }
          format.json { render json: @donation.errors, status: :unprocessable_entity }
        end
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
        redirect_to root_path
      end
    end
end
