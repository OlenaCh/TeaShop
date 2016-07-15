Rails.application.routes.draw do
  get 'signup' => 'users#new'

  root to: 'welcome_page#home'
end
