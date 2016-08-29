class Api::V1::AddressController < ApplicationController
  before_action :authenticate_user!

  def index
  	render json: current_user.addresses.all
  end

  def create
  	address = current_user.addresses.create(city: address_params[:city], 
  		                                    zip_code: address_params[:zip_code], 
  		                                    address: address_params[:address])
  	address.update(is_default: true) if current_user.addresses.count == 1
  end

  private

  def address_params
  	params.permit(:city, :zip_code, :address)
  end
end
