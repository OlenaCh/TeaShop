DeviseTokenAuth.setup do |config|
  config.remove_tokens_after_password_reset = true
  config.default_confirm_success_url = 'www.google.com'
end