Rails.application.routes.draw do
  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  post 'log_in' => 'sessions#create'
  delete 'log_out' => 'sessions#destroy'

  root to: 'welcome_page#home'

  resources :users
end
