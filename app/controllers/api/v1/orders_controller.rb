class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_admin, except: [:index]
  before_action :authenticate_user!, only: [:index]

  def index
    #
  end

  def show
    # @data = Order.find(params[:id])
  end

  def create
    @user = current_user
    # @user = User.find_by_email(params[:email])
    product = Product.find(order_params[:product_id])
    value = order_params[:amount].to_i * product.price # at the moment of creation of order both values are equal
    if @user.current_order == 0
      @order = @user.orders.create(subtotal: value, grand_total: value)
      @user.update(current_order: @order.id)
    else
      @order = @user.orders.find(@user.current_order)
      @order.update(subtotal: count_subtotal(@order.subtotal, product.price),
                    grand_total: count_grand_total(@order.grand_total, product.price))
    end
    @orders_product = @order.orders_products.create(amount: order_params[:amount].to_i, product_id: product.id)
    if @order.save && @orders_product.save
      render status: 200, json: [@order, @orders_product]
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

  def count_subtotal(subtotal, price)
    order_subtotal = subtotal + order_params[:amount].to_i * price
  end

  def count_grand_total(grand_total, price)
    order_grand_total = grand_total + order_params[:amount].to_i * price
  end

  def order_params
    params.permit(:product_id, :amount)
  end
end
