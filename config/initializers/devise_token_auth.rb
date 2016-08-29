DeviseTokenAuth.setup do |config|
  config.remove_tokens_after_password_reset = true
  config.default_confirm_success_url = 'http://localhost:3000/auth/sign_in'#'tea-shop.herokuapp.com'
  config.default_password_reset_url = ''
end
