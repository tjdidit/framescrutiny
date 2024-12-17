class DailiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def index
    @dailies = @project.dailies
  end

  def show
    @daily = @project.dailies.find(params[:id])
    @revisions = @daily.revisions
    @revision = Revision.new
  end

  def new
    @daily = @project.dailies.new
  end

  def create
    @daily = @project.dailies.build(daily_params.merge(user: current_user))
    if @daily.save
      redirect_to project_dailies_path(@project), notice: 'Daily uploaded successfully.'
    else
      render :new
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def daily_params
    params.require(:daily).permit(:video)
  end
end
