class Api::V1::TestsController < ApplicationController

  # def index
  #   @tests = User.all
  # end

  # def show
  # end

  # def create
  #   @user = User.new user_params
  #   if @user.save
  #     render status: 200, json: @user
  #   else
  #     render status: 400, json: @user.errors
  #   end
  # end

  # def edit
  # end

  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private
  def user_params
    params = params.require(:user).permit(:name, :zip_code, :city, :address, :email, :password)
  end

end
