module Docs::Api::V1
  module PasswordsController
    extend ActiveSupport::Concern

    included do
      swagger_controller :passwords, 'Password management'

      swagger_api :create do
        summary 'Creates a reset Password request'
        param :form, 'email', :string, :required, 'Email'
        param :form, 'redirect_url', :string, :required, 'Redirect URL(any)'
        response :ok, 'Success'
        response :not_found
        response :bad_request
      end

      swagger_api :edit do
        summary 'Resets password if parameters are met'
        param :form, 'reset_password_token', :string, :required, 'Token from email sent'
        response :unauthorized
        response :not_found
      end

      # swagger_api :update do
      #   summary 'Updates an existing Product'
      #   param :path, :id, :integer, :required, 'Product Id'
      #   param :form, 'title', :string, :required, 'Title'
      #   param :form, 'short_description', :string, :required, 'Short description'
      #   param :form, 'long_description', :string, :required, 'Long description'
      #   param :form, 'price', :integer, :required, 'Price'
      #   param :form, 'image', :file, :optional, 'Image'
      #   param :form, 'uid', :string, :required, 'uid - get at session creation'
      #   param :form, 'access-token', :string, :required, 'access-token - get at session creation'
      #   param :form, 'client', :string, :required, 'client - get at session creation'
      #   response :ok, 'Success'
      #   response :bad_request
      #   response :not_found
      # end
    end
  end
end