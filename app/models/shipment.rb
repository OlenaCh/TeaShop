class Shipment < ActiveRecord::Base
  has_many :orders

  validates :title, presence: true, length: { in: 2..40 }
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
end
