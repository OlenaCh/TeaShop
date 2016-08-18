class Api::V1::OrdersController < ApplicationController
  # before_action :authenticate_admin, except: [:index]
  # before_action :authenticate_user!, only: [:index]

  def index
    #
  end

  def show
    # @data = Order.find(params[:id])
  end

  def create
    subtotal = 0
    total = 0
    current_user = User.find_by_email(params[:email])
    @order = current_user.orders.create(shipment: order_params[:shipment].to_i)
    products = order_params[:products]
    products.each do |item|
      details = item.last
      product_id = details[:id].to_i
      product_amount = details[:amount].to_i
      @order.orders_products.create(product_id: product_id, amount: product_amount)
      subtotal = subtotal + product_amount * Product.find_by_id(product_id).price
      total = order_params[:shipment].to_i + subtotal
    end
    @order.update(subtotal: subtotal, grand_total: total)
    if @order.save
      render status: 200, json: @order
    else
      render status: 400, json: @order.errors
    end
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

  # def render_creation_error
  #   render json: {
  #       errors: ["No order created!"]
  #   }, status: 400
  # end
  #
  # def render_parameters_error
  #   render json: {
  #       errors: ["Unprocessable parameters!"]
  #   }, status: 422
  # end
  #
  # def just_do_sth_with product
  #   @order = create_order product.price
  #   if !(@order.save)
  #     render_creation_error
  #   else
  #     @orders_product = create_element_of_order_list(@order, product.id)
  #     if !(@orders_product.save)
  #       @order.destroy
  #       render_creation_error
  #     else
  #       render status: 200, json: [@order, @orders_product]
  #     end
  #   end
  # end
  #
  # def create_order price
  #   user = User.find_by_email(params[:email])
  #   # user = current_user
  #   if user.current_order == 0
  #     order = user.orders.create(subtotal: count_value(price), grand_total: count_value(price))
  #     user.update(current_order: order.id)
  #   else
  #     order = user.orders.find(user.current_order)
  #     order.update(subtotal: count_subtotal(order.subtotal, price),
  #                  grand_total: count_grand_total(order.grand_total, price))
  #   end
  #   order
  # end
  #
  # def create_element_of_order_list(order, product)
  #   orders_product = order.orders_products.find_by_product_id(product)
  #   if orders_product
  #     orders_product.update(amount: orders_product.amount + order_params[:amount].to_i)
  #   else
  #     orders_product = order.orders_products.create(amount: order_params[:amount].to_i, product_id: product)
  #   end
  #   orders_product
  # end
  #
  # def count_value price
  #   order_params[:amount].to_i * price
  # end
  #
  # def find_product
  #   Product.find_by_id(order_params[:product_id])
  # end
  #
  # def count_subtotal(subtotal, price)
  #   subtotal + order_params[:amount].to_i * price
  # end
  #
  # def count_grand_total(grand_total, price)
  #   grand_total + order_params[:amount].to_i * price
  # end

  def order_params
    params.permit(:shipment, products: [:id, :amount])
  end
end