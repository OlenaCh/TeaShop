class Order < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :orders_products
  has_many :orders, through: :orders_products

  validates :shipment, :numericality => { :greater_than_or_equal_to => 0 }
  validates :subtotal, :numericality => { :greater_than_or_equal_to => 0 }
  validates :grand_total, :numericality => { :greater_than_or_equal_to => 0 }
end
