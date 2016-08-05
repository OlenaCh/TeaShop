class Api::V1::Users::SessionsController < DeviseTokenAuth::SessionsController
  def create
    super
  end

  private

  def render_create_success
    @user = User.find_by_email(resource_params[:email])
    if @user.role == 'admin'
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