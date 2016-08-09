class Api::V1::Users::PasswordsController < DeviseTokenAuth::PasswordsController
  before_action :authenticate_user!
end