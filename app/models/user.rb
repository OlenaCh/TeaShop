class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :zip_code, presence: true, length: { maximum: 10 }

  VALID_CITY_REGEX = /[^0-9]/i
  validates :city, presence: true, length: { maximum: 20 },
            format: { with: VALID_CITY_REGEX }
  validates :address, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

end
