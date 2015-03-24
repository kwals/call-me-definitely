Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks:
    "omniauth_callbacks", number: "numbers" }
  
  root 'application#home'

  resources :lifelines, only: :create

  get 'numbers' => 'numbers#show', as: 'number'
  post 'numbers/edit' => 'numbers#update', as: 'number_edit'
  get 'numbers/verify' => 'numbers#show_verify', as: 'verify'
  # post 'authy/verify' => 'numbers#'
  
end

