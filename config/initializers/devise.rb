Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  # If absent, mail is sent from "please-change-me-at-config-initializers-devise@example.com"
  # config.mailer_sender = "support@myapp.com"

  config.navigational_formats = [:json, :html]
end