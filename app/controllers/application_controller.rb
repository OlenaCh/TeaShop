class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  def render_not_found(e)
    render json: {
        error: e
    }, status: 404
  end

  def authenticate_admin
    if current_user
      render_admin_authorization_error if current_user.role != 'admin'
    else
      render_authorization_error
    end
  end

  def for_users_only
    render json: {
        errors: ["Users only."]
    }, status: 401 if current_user.role != 'user'
  end

  def render_admin_authorization_error
    render json: {
        errors: ["Admins only."]
    }, status: 401
  end

  def render_authorization_error
    render json: {
        errors: ["Authorized users only."]
    }, status: 401
  end
end
