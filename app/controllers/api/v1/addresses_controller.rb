class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_user!, :for_users_only
  before_action :address_can_be_modified?, except: [:index, :create]

  def index
  	render json: current_user.addresses.all
  end

  def create
  	address = current_user.addresses.create(city: address_params[:city], 
  		                                      zip_code: address_params[:zip_code], 
  		                                      address: address_params[:address])
  	address.update(is_default: true) if current_user.addresses.count == 1
    if address.save      
      render status: 200, json: { message: ['Success!'] }
    else
      render status: 400, json: { errors: ['No address created!'] }
    end
  end

  def update
    address = Address.find_by_id(address_params[:address_id])
    if address
      address.update(city: address_params[:city]) if address_params[:city] != ''
      address.update(zip_code: address_params[:zip_code]) if address_params[:zip_code] != ''
      address.update(address: address_params[:address]) if address_params[:address] != ''
      if address_params[:is_default] == 1
        current_user.addresses.find_by_is_default(true).update(is_default: false)
        address.update(is_default: true)
      end
      render status: 200, json: { message: ['Success!'] }
    else
      render_not_found 'Object not found'
    end
  end

  def destroy
    address = Address.find_by_id(address_params[:address_id])    
    if address 
      address.destroy 
      render status: 200, json: { message: ['Success!'] }
    else
      render_not_found 'Object not found'
    end
  end

  private

  def address_can_be_modified?
    if current_user.role == 'user' && Address.find_by_id(address_params[:address_d]).user_id != current_user.id 
      render json: {
        errors: ["You are not authorized to modify this address!"]
      }, status: 401
    end
  end

  def address_params
  	params.permit(:address_id, :city, :zip_code, :address, :is_default)
  end	
end