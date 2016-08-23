class Api::V1::Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
  include Docs::Api::V1::RegistrationsController

  def create
    super
  end

  private

  def sign_up_params
    params.permit(:name, :zip_code, :city, :address, :email, :password)
  end
end
