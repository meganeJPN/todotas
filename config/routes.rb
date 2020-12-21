Rails.application.routes.draw do
  root to: 'home#index'
  get 'user', to:  'home#index'

  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update]
  end
end