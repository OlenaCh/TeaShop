class Api::V1::Users::SessionsController < DeviseTokenAuth::SessionsController
  def create
    super
    @user = User.find_by_email(resource_params[:email])
    # if !!@user
    #   admin_path if @user.role == 'user'
    # end
  end
end