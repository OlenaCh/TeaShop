ActionMailer::Base.delivery_method = :smtp
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