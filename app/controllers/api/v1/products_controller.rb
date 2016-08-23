class Api::V1::ProductsController < ApplicationController
  include Docs::Api::V1::ProductsController
  before_action :authenticate_admin, except: [:show, :index]
  before_action :authenticate_user!, only: [:show, :index]

  def create
    @product = Product.new product_params
    if @product.save
      render status: 200, json: @product
    else
      render status: 400, json: @product.errors
    end
  end

  def index
    @products=Product.all
    render json: {
        products: @products.order(sort_column + ' ' + sort_direction).page(params[:page]).per(count)
    }
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
      redirect_to api_v1_products_path, format: :json
    else
      render_not_found 'Object not found'
    end
  end

  private

  def product_params
    params.permit(:title, :short_description, :long_description,
                  :price, :exists, :image)
  end

  def sort_column
    params[:sort] || 'title'
  end

  def count
    params[:count]
  end

  def sort_direction
    (!params[:direction].present? || params[:direction] == 'asc') ? 'asc' : 'desc'
  end
end