class Api::V1::UsersController < ApplicationController

  # def update
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  # end

  private
  def user_params
    params = params.require(:user).permit(:name, :zip_code, :city, :address, :email, :password)
  end
end