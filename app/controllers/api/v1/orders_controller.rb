class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_admin, except: [:create]
  before_action :authenticate_user!, only: [:create]

  def index
    @list = Array.new
    # @orders = Order.all.orders_products
    @orders = Order.all
    @orders.each do |order|
      @list << order
      order.orders_products.each do |order_product|
        item = Array.new
        item << order_product << Product.find_by_id(order_product.product_id)
      end
    end
    # @orders.each do |order|
    #   items = order.orders_products
    #   items.each do |item|
    #     id = order.order_id
    #     product = Product.find_by_id(item.product_id)
    #     title = product.title
    #     price = order.orders_products.amount * product.price
    #     @list << Hash.new(:id => id, :title => title, :price => price)
    #   end
    # end
    render json: @list
  end

  def create
    subtotal = 0
    @order = current_user.orders.create(shipment: create_params[:shipment].to_i)
    create_params[:products].each do |item|
      @object = @order.orders_products.create(product_id: item.last[:id].to_i, amount: item.last[:amount].to_i)
      subtotal = subtotal + item.last[:amount].to_i * Product.find_by_id(item.last[:id].to_i).price
    end
    @order.update(subtotal: subtotal, grand_total: create_params[:shipment].to_i + subtotal)
    if @order.save
      render status: 200, json: @order
    else
      @order.destroy
      render status: 400, json: { errors: ['No order created!'] }
    end
  end

  def update
    @order = Order.find_by_id(params[:id])
    if @order
      @order.update(status: update_params[:status])
      render status: 200, json: @order
    else
      render_not_found 'Object not found'
    end
  end

  def destroy
    @order = Order.find_by_id(params[:id])
    if @order
      @order.destroy
      redirect_to api_v1_orders_path, format: :json
      # render status: 200, json: { notice: ['Success'] }
    else
      render_not_found 'Object not found'
    end
  end

  private

  def create_params
    params.permit(:shipment, products: [:id, :amount])
  end

  def update_params
    params.permit(:status)
  end
end