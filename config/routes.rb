Rails.application.routes.draw do
  get 'sign_up' => 'users#new'

  root 'welcome_page#home'
  resource :users
end
