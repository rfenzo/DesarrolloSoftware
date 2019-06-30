# frozen_string_literal: true

class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_profile_variables, except: %i[index show]
  before_action :set_ranking_variables, only: %i[index show]
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects
  def index
    if params.key? :search_text
      text = params.require :search_text
      @projects = Project.select { |p| p.name.include?(text) || p.description.include?(text) }
    else
      @projects = Project.all
    end
    @projects.map(&:calculate_donations)
  end

  # GET /projects/1
  def show
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
      redirect_to :social_projects
    else
      flash[:error] = t(:new, scope: %i[flash project error])
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      flash[:success] = t(:edit, scope: %i[flash project success], project: @project.name)
      redirect_to :social_projects
    else
      flash[:error] = t(:edit, scope: %i[flash project error])
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    flash[:success] = t(:destroy, scope: %i[flash project success], project: @project.name)
    redirect_to :social_projects
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find_by(id: params[:id])
    @project.calculate_donations
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
