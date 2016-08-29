class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :name, presence: true, length: { in: 2..40 }  
end
