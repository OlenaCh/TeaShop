class Api::V1::OrdersController < ApplicationController
  # before_action :authenticate_admin, except: [:create, :show]
  # before_action :authenticate_user!, only: [:create, :show]
  # before_action :for_users_only, only: [:create, :show]

  def index
    @list = Array.new
    @orders = Order.all
    @item = Array.new 
    @orders.each do |order|
      @list << User.find_by_id(order.user_id) << order << Address.find_by_id(order.address_id)
      order.orders_products.each do |order_product|  
        @list << order_product << Product.find_by_id(order_product.product_id)
      end 
    end
    render json: @list
  end

  def create
    subtotal = 0    
    shipment = Shipment.find_by_id(create_params[:shipment_id])
    @order = current_user.orders.create(shipment_id: shipment.id, address_id: create_params[:address_id])
    create_params[:products].each do |item|
      @order.orders_products.create(product_id: item.last[:id].to_i, amount: item.last[:amount].to_i)
      subtotal = subtotal + item.last[:amount].to_i * Product.find_by_id(item.last[:id].to_i).price
    end
    @order.update(subtotal: subtotal, grand_total: shipment.price + subtotal)
    if @order.save
      UserMailer.order_creation(current_user.email).deliver_now
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
      # render status: 200, json: { notice: ['Success!'] }
      redirect_to api_v1_orders_path, format: :json
    else
      render_not_found 'Object not found'
    end
  end

  private

  def create_params
    params.permit(:shipment_id, :address_id, products: [:id, :amount])
  end

  def update_params
    params.permit(:status)
  end
end
