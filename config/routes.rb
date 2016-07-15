Rails.application.routes.draw do
  get 'sign_up' => 'users#new'
  root to: 'welcome_page#home'
  resources :users
end
