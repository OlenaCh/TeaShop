class OrdersProduct < ActiveRecord::Base
  belongs_to :product, dependent: :destroy
  belongs_to :order, dependent: :destroy
end
