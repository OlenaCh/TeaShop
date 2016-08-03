Devise.setup do |config|
  config.mailer_sender = "teashoplviv@gmail.com"
  config.navigational_formats = [:json, :html]
  config.reconfirmable = false
end