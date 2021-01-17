Rails.application.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'v1/auth/registrations'
  }
  end
  root to: 'home#index'
  get 'user', to:  'home#index'
  get 'users/signup', to:  'home#index'
  get 'users/login', to:  'home#index'
  get 'users/account', to:  'home#index'
  get 'users/edit', to:  'home#index'

  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update, :show, :destroy]
    resources :schedules, only: [:index, :create, :show, :destroy]
  end
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end