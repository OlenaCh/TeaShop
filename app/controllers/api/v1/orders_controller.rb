class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_admin, except: [:index]
  before_action :authenticate_user!, only: [:index]

  def index
    #
  end

  def create
    #
  end

  def edit
    #
  end

  def update
    #
  end

  private

  def authenticate_admin
    if current_user
      render_admin_authorization_error if current_user.role != 'user'
    else
      render_authorization_error
    end
  end

  def render_admin_authorization_error
    render json: {
        errors: ["Users only."]
    }, status: 401
  end
end
