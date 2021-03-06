Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: '/auth',
      controllers: {
      registrations:  'api/v1/users/registrations',
      sessions:       'api/v1/users/sessions',
      passwords:      'api/v1/users/passwords'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products
      resources :orders
      resources :shipments, only: [:index]
      resources :addresses, except: [:show, :new]
      resources :users, except: [:index]
    end
  end

  get '/api' => redirect('/swagger/dist/index.html?url=/api/v1/api-docs.json')

  root to: "application#index"
end






