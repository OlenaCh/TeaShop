module Docs::Api::V1
  module RegistrationsController
    extend ActiveSupport::Concern

    included do
      swagger_controller :users, 'All users'

        swagger_api :create do
          summary 'Creates a new User'
          param :form, 'name', :string, :required, 'Name'
          param :form, 'email', :string, :required, 'Email'
          param :form, 'password', :string, :required, 'Password'
          param :form, 'zip_code', :string, :required, 'Zip-code'
          param :form, 'city', :string, :required, 'City'
          param :form, 'address', :string, :required, 'Address'
          response :ok, 'Success'
          response :bad_request
          response 422
        end

    end
  end
end