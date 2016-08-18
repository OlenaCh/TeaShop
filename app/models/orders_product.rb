class OrdersProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, dependent: :destroy

  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }
end
