class Api::V1::UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show ]
  before_action :find_user, only: [:show ]


  def index
    @users = User.page params[:page]
    render json: @users
  end

  def show
    render status: 200, json: { user: @user }
  end

  def create
    @user = User.new user_params

      render status: 200, json: @user
    else
      render status: 400, json: @user.errors
    end
  end

  def edit
    render status: 200, json: { user: @user }
  end

  def update
    if @user.update user_params
      render status: 200, json: @user
    else
      render status: 400, json: @user.errors
    end
  end

  # def destroy
  #
  # end

  private

  def user_params
    param = params.require(:user).permit(:name, :zip_code, :city, :address, :email, :password )
  end

  def find_user
    @user = User.find_by!(id: params[:id])
  end

end
