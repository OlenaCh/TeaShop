class Api::V1::Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
  include Docs::Api::V1::RegistrationsController

  def create
    super
    if params[:city] && params[:zip_code] && params[:address]
      current_user.addresses.create(city: params[:city], zip_code: params[:zip_code], 
                                    address: params[:address], is_default: true)
    end
  end

  private

  def sign_up_params
    params.permit(:name, :email, :password)
  end
end
