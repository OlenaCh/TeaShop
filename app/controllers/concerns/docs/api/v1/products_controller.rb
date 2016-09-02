module Docs::Api::V1
  module ProductsController
    extend ActiveSupport::Concern

    included do
      swagger_controller :products, 'All products'

      swagger_api :index do
        summary 'Fetches all Product items'
        notes 'This lists all products'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response :unauthorized
        response :ok, 'Success'
        response :not_found
      end

      swagger_api :show do
        summary 'Fetches a single Product'
        param :path, :id, :integer, :required, 'Product Id'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response :ok, 'Success'
        response :unauthorized
        response :not_found
      end

      swagger_api :create do
        summary 'Creates a new Product'
        param :form, 'title', :string, :required, 'Title'
        param :form, 'short_description', :string, :required, 'Short description'
        param :form, 'long_description', :string, :required, 'Long description'
        param :form, 'price', :integer, :required, 'Price'
        param :form, 'image', :file, :optional, 'Image'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response :ok, 'Success'
        response :unauthorized
        response :bad_request
      end

      swagger_api :edit do
        summary 'Fetches a single Product item for edit'
        param :path, :id, :integer, :required, 'Product Id'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response :ok, 'Success'
        response :unauthorized
        response :not_found
      end

      swagger_api :update do
        summary 'Updates an existing Product'
        param :path, :id, :integer, :required, 'Product Id'
        param :form, 'title', :string, :required, 'Title'
        param :form, 'short_description', :string, :required, 'Short description'
        param :form, 'long_description', :string, :required, 'Long description'
        param :form, 'price', :integer, :required, 'Price'
        param :form, 'image', :file, :optional, 'Image'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response :ok, 'Success'
        response :bad_request
        response :not_found
      end

      swagger_api :destroy do
        summary 'Deletes an existing Product item'
        param :path, :id, :integer, :required, 'Product Id'
        param :form, 'uid', :string, :required, 'uid - get at session creation'
        param :form, 'access-token', :string, :required, 'access-token - get at session creation'
        param :form, 'client', :string, :required, 'client - get at session creation'
        response 302, 'Redirect if success'
        response :unauthorized
        response :not_found
      end
    end
  end
end