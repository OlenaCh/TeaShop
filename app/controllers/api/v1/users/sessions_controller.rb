class Api::V1::Users::SessionsController < DeviseTokenAuth::SessionsController
  include Docs::Api::V1::SessionsController
  before_action :authenticate_user!, except: [:create]

  def create
    super
  end

  private

  def render_create_success
    if current_user.role == 'admin'
      # render json: {
      #   action: 'admin#show'
      # }
    else
      render json: {
        data: resource_data(resource_json: @resource.token_validation_response)
      }
    end
  end
end