class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_admin, except: [:index]
  before_action :authenticate_user!, only: [:index]

  def index
    #
  end

  def create
    user = current_user
    if user.current_order == nil
      @order = create_order
    else
      @order = update_order(user.current_order)
    end
    @orders_product = create_connection @order.id
    if @order.save && @orders_product.save
      render status: 200, json: @order
    else
      render status: 400, json: @order.errors
    end
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

  def create_order
    order = Order.new
    order.subtotal = item.amount * Product.find(order_params[:product_id]).price
    order.grand_total = order.subtotal
    order
  end

  def update_order id
    order = Order.find(id)
    order.subtotal = order.subtotal + item.amount * Product.find(item.product_id).price
    order.grand_total = order.grand_total + item.amount * Product.find(item.product_id).price
    order
  end

  def create_connection id
    connection = OrdersProduct.new
    connection.amount = order_params[:amount]
    connection.order_id = id
    connection.product_id = Product.find(order_params[:product_id]).id
    connection
  end

  def order_params
    params.permit(:product_id, :amount)
  end
end
