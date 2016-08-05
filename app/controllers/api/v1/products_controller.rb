class Api::V1::ProductsController < ApplicationController

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
    #
  end

  def show
    render json: Product.select(params[:product])
  end

  def update
    #
  end

  def destroy
    #
  end

  private
  def product_params
    params.permit(:title, :short_description, :long_description,
                  :price, :exists, :image)
  end
end
