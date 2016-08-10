class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_many :orders, dependent: :destroy

  before_save :downcase_city, :downcase_address

  validates :name, presence: true, length: { in: 2..40 }
  validates :zip_code, presence: true, length: { in: 4..11 }

  VALID_CITY_REGEX = /\A[a-zA-Z0-9\-\s]+\z/i
  validates :city, presence: true, length: { in: 2..20 },
            format: { with: VALID_CITY_REGEX }

  validates :address, presence: true, length: { in: 2..40 }

  private

  def downcase_city
    self.city = city.downcase
  end

  def downcase_address
    self.address = address.downcase
  end
end
