class Item < ActiveRecord::Base
  belongs_to :product
  has_many :orders, through :order_list
end
