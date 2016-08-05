class Api::V1::ProductsController < ApplicationController
  def new
    #
  end

  def create
    #
  end

  def index
    render json: Product.all
  end

  def edit
    #
  end

  def show
    render json: Product.select(:product)
  end

  def update
    #
  end

  def destroy
    #
  end
end
