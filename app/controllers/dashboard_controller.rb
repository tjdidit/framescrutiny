class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_user
  before_action :authenticate_user!

  def index
     @projects = current_user.projects
    Rails.logger.debug "Projects for dashboard: #{@projects.inspect}"    
    case current_user.role
    when 'admin'
      @dailies = Daily.all
      @users = User.all
      @new_user = User.new
    when 'lead_animator'
      @dailies = Daily.all
    when 'animator'
      @revisions = current_user.assigned_revisions
    end
  end

def create_user
  Rails.logger.debug "Params received: #{params.inspect}"

  password = SecureRandom.hex(4) # Generate an 8-character random password
  @user = User.new(user_params.merge(password: password, password_confirmation: password))

  if @user.save
    render json: { user: @user, password: password }, status: :ok
  else
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
rescue ActionController::ParameterMissing => e
  Rails.logger.error "ParameterMissing: #{e.message}"
  render json: { error: e.message }, status: :unprocessable_entity
end

private

def user_params
  params.require(:user).permit(:username, :email, :role)
end
end
