class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orders_products, dependent: :destroy
  has_many :products, through: :orders_products

  validates :shipment, :numericality => { :greater_than_or_equal_to => 0 }
  validates :subtotal, :numericality => { :greater_than_or_equal_to => 0 }
  validates :grand_total, :numericality => { :greater_than_or_equal_to => 0 }
end
