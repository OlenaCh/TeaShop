class Api::V1::UsersController < ApplicationController
  before_action :authenticate_admin, except: [:show]
  before_action :authenticate_user!, only: [:show]
  before_action :for_users_only, only: [:show]

  def show
  	@info = Array.new
  	user = User.find_by_email(current_user.email)
  	@info << user << user.addresses.all
  	render json: @info
  end

  def destroy
  	user = User.find_by_id(user_params[:id])
  	user.destroy
  	render status: 200, json: { message: ['User deleted successfully!'] }
  end

  private

  def user_params
  	params.permit(:id)
  end
end
