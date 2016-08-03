ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "25",
    :domain => 'gmail.com',
    :user_name => "teashoplviv@gmail.com",
    :password => "1teashop@",
    :authentication => "plain",
    :enable_starttls_auto => true
}