class Api::V1::UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.page params[:page]
    render json: @users
  end

  def show
    render status: 200, json: { user: @user, partners: partners }
  end

  def create
    @user = User.new user_params
    # @user.password = '11111111'

    if @user.save
      # unless params[:user][:sub_services_id].empty?
      #   params[:user][:sub_services_id].each do |sub_service_id|
      #     @user.sub_services << SubService.find_by!(id: sub_service_id)
      #   end
      # end
      #
      # MailChimpSubscriber.new.subscribe_with_sub_services @user, params[:user][:service_id]
      # NotificationMailer.send_subscribe_notification(@user.email).deliver_now
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
    param = params.require(:user).permit(:name, :email, :password, :password_confirmation, :zip_code, :city, :address)
  end

  def find_user
    @user = User.find_by!(id: params[:id])
  end

  def partners
    @user.partnerships_owner.map{ |p| p.partner }.flatten + @user.partnerships_partner.map{ |p| p.owner }.flatten
  end

end
