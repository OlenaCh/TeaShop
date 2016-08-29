class Api::V1::ShipmentController < ApplicationController
  # include Docs::Api::V1::ShipmentController
  before_action :authenticate_user!

  def index
  	render json: Shipment.all
  end
 end