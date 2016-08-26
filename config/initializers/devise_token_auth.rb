DeviseTokenAuth.setup do |config|
  config.remove_tokens_after_password_reset = true
  config.default_confirm_success_url = 'tea-shop.herokuapp.com/auth/sign_in'
  config.default_password_reset_url = 'tea-shop.herokuapp.com/auth/password/edit'
end
