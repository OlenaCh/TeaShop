class Product < ActiveRecord::Base
  validates :title, presence: true, length: { in: 2..60 }, uniqueness: true
  validates :short_description, presence: true, length: { in: 2..100 }
  validates :long_description, presence: true, length: { in: 2..500 }
  validates :price, presence: true, numericality: { only_float: true }
end
