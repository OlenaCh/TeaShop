class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orders_products
  has_many :orders, through: :orders_products
end
