class Api::V1::Users::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private

  def sign_up_params
    params.permit(:name, :zip_code, :city, :address, :email, :password)
  end
end
