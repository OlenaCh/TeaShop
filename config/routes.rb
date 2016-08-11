Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'api/v1',
      controllers: {
      registrations:  'api/v1/users/registrations',
      sessions:       'api/v1/users/sessions',
      passwords:      'api/v1/users/passwords'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, except: [:new]
      resources :orders
    end
  end

  root to: "application#index"
end






