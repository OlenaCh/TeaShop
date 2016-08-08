class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  def render_not_found(e)
    render status: 404, json: { error: e }
  end
end
