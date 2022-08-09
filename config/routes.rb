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
  resources :slot, only: [:index, :new, :create, :destroy]
  resources :transaction, except: [:edit, :update, :create]
  get 'complete-transaction', to: 'transaction#complete'
  post 'testpost-post', to: 'transaction#testpost'


  namespace :admin do
    resources :dashboard
    resources :inventory
    resources :transaction, only: [:index, :show, :destroy]
  end

  namespace :payments do
    post '/gcash-payment', to: 'gcash_payment#create'
    get '/gcash-payment/success', to: 'gcash_payment#success'
    get '/gcash-payment/failed', to: 'gcash_payment#failed'
  end

  namespace :paymongo do
    post "/webhook", to: "webhook#create"
  end
end
