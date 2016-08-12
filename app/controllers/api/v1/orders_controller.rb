class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_admin, except: [:index]
  before_action :authenticate_user!, only: [:index]

  def index
    #
  end

  def create
    # @item = create_item
    # user = current_user
    # if user.current_order == nil
    #   @order = create_order @item
    # else
    #   @order = update_order(user.current_order, @item)
    # end
    # @order_list = OrderList.new(@order.id, @item.id)
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

  # def create_item
  #   item = Item.new
  #   item.amount = order_item_params[:amount]
  #   item.product_id = Product.find(order_item_params[:product_id]).id
  #   item
  # end
  #
  # def create_order item
  #   order = Order.new
  #   order.subtotal = item.amount * Product.find(item.product_id).price
  #   order.grand_total = order.subtotal
  #   order
  # end
  #
  # def update_order(id, item)
  #   order = Order.find(id)
  #   order.subtotal = order.subtotal + item.amount * Product.find(item.product_id).price
  #   order.grand_total = order.grand_total + item.amount * Product.find(item.product_id).price
  #   order
  # end
  #
  # def order_item_params
  #   params.permit(:product_id, :amount)
  # end
end
