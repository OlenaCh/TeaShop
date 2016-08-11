class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_admin, except: [:index]
  before_action :authenticate_user!, only: [:index]

  def index
    #
  end

  def create
    # @order = Order.new
    # @tem = Item.new item_params
    # @order.items << @item
    # if @order.save && @item.save
    #   render status: 200, json: @order
    # else
    #   render status: 400, json: @order.errors
    # end
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

  # def item_params
  #   params.permit(:id, :amount)
  # end
end
