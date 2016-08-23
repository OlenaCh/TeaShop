module Docs::Api::V1
  module SessionsController
    extend ActiveSupport::Concern

    included do
      swagger_controller :user_session, 'Manages User session'

      # swagger_api :index do
      #   summary 'Fetches all Product items'
      #   notes 'This lists all products'
      #   response :unauthorized
      #   response :ok, 'Success'
      #   response :not_found
      # end
      #
      # swagger_api :show do
      #   summary 'Fetches a single Product'
      #   param :path, :id, :integer, :required, 'Product Id'
      #   response :ok, 'Success'
      #   response :unauthorized
      #   response :not_found
      # end

      swagger_api :create do
        summary 'Creates a new Session on sign in'
        param :form, 'email', :string, :required, 'Email'
        param :form, 'password', :string, :required, 'Password'
        response :ok, 'Success'
        response :unauthorized
        response :bad_request
      end

      # swagger_api :edit do
      #   summary 'Fetches a single Product item for edit'
      #   param :path, :id, :integer, :required, 'Product Id'
      #   response :ok, 'Success'
      #   response :unauthorized
      #   response :not_found
      # end
      #
      # swagger_api :update do
      #   summary 'Updates an existing Product'
      #   param :path, :id, :integer, :required, 'Product Id'
      #   param :form, 'product[title]', :string, :required, 'Title'
      #   param :form, 'product[short_description]', :string, :required, 'Short description'
      #   param :form, 'product[long_description]', :string, :required, 'Long description'
      #   param :form, 'product[price]', :integer, :required, 'Price'
      #   param :form, 'product[image]', :file, :optional, 'Image'
      #   response :ok, 'Success'
      #   response :bad_request
      #   response :not_found
      # end
      #
      swagger_api :destroy do
        summary 'Deletes an existing Session on log out'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response :ok, 'Success'
        response :unauthorized
        response :not_found
      end
    end
  end
end