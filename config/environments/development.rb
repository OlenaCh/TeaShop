Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :letter_opener
  host = 'mighty-sands-49511.herokuapp.com'                                          #need to change
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true
end
