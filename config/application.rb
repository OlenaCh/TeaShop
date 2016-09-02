require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Teashop
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.initialize_on_precompile = false

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options], :credentials => true
      end
    end
  end
end