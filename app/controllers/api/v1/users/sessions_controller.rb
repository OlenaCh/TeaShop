class Api::V1::Users::SessionsController < DeviseTokenAuth::SessionsController
  include Docs::Api::V1::SessionsController
  before_action :authenticate_user!, except: [:create]

  def create
    super
  end
end