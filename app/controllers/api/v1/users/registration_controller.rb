class Api::V1::Users::RegistrationController < ApplicationController
  DeviseTokenAuth::RegistrationsController

  private

  def sign_up_params
    params.permit(:name, :email, :password, :zip_code, :city, :address)
  end
end
