Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root to: "home#index"

  resources :appointment
  resources :products, only: [:index, :show]
  resources :cart, only: [:index, :create, :destroy]
<<<<<<< HEAD
  resources :slot, only: [:index, :new, :create, :destroy]
=======
  resources :transaction, except: [:edit, :update]
>>>>>>> 3437e24a80d5ac31f31af45621dd0da6f6f6f490

  namespace :admin do
    resources :dashboard
    resources :inventory
    resources :transaction, only: [:index, :show, :destroy]
  end
end
