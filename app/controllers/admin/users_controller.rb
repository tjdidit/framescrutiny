class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def create
    password = Devise.friendly_token[0, 8] # Generate an 8-character random password
    @user = User.new(user_params.merge(password: password, password_confirmation: password))

    if @user.save
      render json: { user: @user, password: password }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:username, :email, :role)
  end
end
