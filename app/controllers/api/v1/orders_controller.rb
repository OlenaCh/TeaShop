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
    current_user = User.find_by_email(params[:email])
    @order = current_user.orders.create(shipment: order_params[:shipment].to_i)
    order_params[:products].each do |item|
      @object = @order.orders_products.create(product_id: item.last[:id].to_i, amount: item.last[:amount].to_i)
      subtotal = subtotal + item.last[:amount].to_i * Product.find_by_id(item.last[:id].to_i).price
    end
    @order.update(subtotal: subtotal, grand_total: order_params[:shipment].to_i + subtotal)
    if @order.save
      render status: 200, json: @order
    else
      @order.destroy
      render status: 400, json: { errors: ["No order created!"] }
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

  def order_params
    params.permit(:shipment, products: [:id, :amount])
  end
end