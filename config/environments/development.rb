Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "gmail.com",
      authentication: :plain,
      enable_starttls_auto: true,
      user_name: "teashoplviv@gmail.com",
      password: "1teashop@",
      openssl_verify_mode: 'none'
  }
  config.host = 'localhost:3000'

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true
end
