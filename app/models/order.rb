class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, through: :order_list
end
