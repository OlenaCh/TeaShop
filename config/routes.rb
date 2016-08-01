Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'api/v1',
      controllers: {
      registrations:  'api/v1/users/registrations'
  }

  root to: "application#index"
end






