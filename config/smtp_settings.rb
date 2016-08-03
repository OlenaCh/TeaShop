ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => 'gmail.com',
    :user_name => Figaro.env.gmail_username,
    :password => Figaro.env.gmail_password,
    :authentication => "plain",
    :enable_starttls_auto => true
}