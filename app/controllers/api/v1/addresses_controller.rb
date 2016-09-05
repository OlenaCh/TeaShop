class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :for_users_only, only: [:index, :create]

  def index
  	render json: current_user.addresses.all
  end

  def create
  	address = current_user.addresses.create(city: address_params[:city], 
  		                                      zip_code: address_params[:zip_code], 
  		                                      address: address_params[:address])
  	address.update(is_default: true) if current_user.addresses.count == 1
  end

  def update
  end

  def destroy
  end

  private

  def address_params
  	params.permit(:city, :zip_code, :address)
  end	
end