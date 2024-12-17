class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @dailies = @project.dailies
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params) # Associates the project with the logged-in user

    if @project.save
      render json: @project, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end
  private

def project_params
    params.require(:project).permit(:name, :description)
  end
end