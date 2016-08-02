Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      authentication: 'plain',
      enable_starttls_auto: true,
      user_name: Figaro.env.gmail_username,
      password: Figaro.env.gmail_password,
      openssl_verify_mode: 'none'
  }

  # config.action_mailer.default_url_options = { host: ENV["SMTP_DOMAIN"] }

  # config.action_mailer.delivery_method = :letter_opener
  host = 'mighty-sands-49511.herokuapp.com'                                          #need to change

  config.action_mailer.default_url_options = { host: host, protocol: 'http' }

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true
end
