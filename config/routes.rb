Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root to: "home#index"

  resources :appointment, only: [:index]
  resources :products, only: [:index, :show]
  resources :cart, only: [:index, :create, :destroy]
  resources :slot, only: [:index, :new, :create, :destroy]

  namespace :admin do
    resources :dashboard
    resources :inventory
  end
end
