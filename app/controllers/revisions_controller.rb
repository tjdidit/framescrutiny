class RevisionsController < ApplicationController
  before_action :set_project_and_daily
  before_action :require_admin, only: [:destroy]

def create
  @revision = @daily.revisions.build(revision_params)
  @revision.user = current_user # Associate the logged-in user

  if @revision.save
    redirect_to project_daily_path(@project, @daily), notice: 'Revision added successfully.'
  else
    flash.now[:alert] = 'Failed to add revision.'
    @revisions = @daily.revisions
    render 'dailies/show'
  end
end

 def destroy
    @revision = Revision.find(params[:id])
    @revision.destroy
    # Redirect to the daily's show page after deletion
    redirect_back fallback_location: project_daily_path(@revision.daily.project, @revision.daily), 
                  notice: "Revision deleted successfully."
  end

  private

  def set_project_and_daily
    @project = Project.find_by(id: params[:project_id])
    if @project.nil?
      redirect_to projects_path, alert: "Project not found." and return
    end

    @daily = @project.dailies.find_by(id: params[:daily_id])
    if @daily.nil?
      redirect_to project_path(@project), alert: "Daily not found." and return
    end
  end

  def revision_params
    params.require(:revision).permit(:timestamp, :comment)
  end
end

  def require_admin
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end