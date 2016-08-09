class Api::V1::Users::PasswordsController < DeviseTokenAuth::PasswordsController
  before_action :authenticate_user_email, only: [:create]

  private
  def authenticate_user_email
    user = User.find_by_email params[:email]
    unless user
      return render json: {
          errors: ["Authorized users only."]
      }, status: 401
    end
  end
end