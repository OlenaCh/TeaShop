class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, length: { in: 2..50 }
  # validates :zip_code, presence: true, length: { in: 2..50 }
  # validates :city, presence: true, length: { in: 2..50 }
  # validates :address, presence: true, length: { in: 2..50 }
end
