class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  def render_not_found(e)
    render json: {
        error: e
    }, status: 404
  end

  def render_authorization_error
    render json: {
        errors: ["Authorized users only."]
    }, status: 401
  end

  # def api
  #   render layout: false
  # end

end
