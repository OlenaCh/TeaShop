Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

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
      user_name: ENV['TEASHOP_GMAIL_NAME'],
      password: ENV['TEASHOP_GMAIL_PASSWORD'],
      openssl_verify_mode: 'none'
  }
  config.host = 'localhost:3000'

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
      :login => ENV['TEASHOP_PAYPAL_LOGIN'],
      :password => ENV['TEASHOP_PAYPAL_PASSWORD'],
      :signature => ENV['TEASHOP_PAYPAL_SIGNATURE']
    )
  end
end
