Rails.application.routes.draw do
  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  post 'log_in' => 'sessions#create'

  root to: 'welcome_page#home'

  resources :users do
    member do
      get :confirm_email
    end
  end
end
