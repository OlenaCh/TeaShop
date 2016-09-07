Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['TEASHOP_FACEBOOK_KEY'], ENV['TEASHOP_ACEBOOK_SECRET']
  provider :linkedin, ENV['TEASHOP_LINKEDIN_KEY'], ENV['TEASHOP_LINKEDIN_SECRET']
end