class Api::V1::ProductsController < ApplicationController
  # before_action :authenticate_user!

  def new
  end

  def create
    @product = Product.new product_params
    if @product.save
      render status: 200, json: @product
    else
      render status: 400, json: @product.errors
    end

  end

  def index
    render json: Product.all
  end

  def edit
    @product = Product.find_by_id params[:id]
    if @product
      render json: @product
    else
      render_not_found 'Object not found'
    end
  end

  def show
    @product = Product.find_by_id params[:id]
    if @product
      render json: @product
    else
      render_not_found 'Object not found'
    end
  end

  def update
    @product = Product.find_by_id params[:id]
    if @product
      @product.update_attributes!(product_params)
      render status: 200, json: @product
    else
      render_not_found 'Object not found'
    end
  end

  def destroy
    @product = Product.find_by_id params[:id]
    if @product
      @product.destroy
      render status: 200, json: :index
    else
      render_not_found 'Object not found'
    end
  end

  private
  # def authenticate_user
  #   #
  # end

  def product_params
    params.permit(:title, :short_description, :long_description,
                  :price, :exists, :image)
  end
end

# def find_user
#   User.find_by(email: wizard_params[:user][:email]
#   # name: wizard_params[:user][:name],
#   # mobile_phone: wizard_params[:user][:mobile_phone]
#   )
# end