Rails.application.routes.draw do
  devise_for :users
  
  root 'application#home'

  resources :lifelines, only: :create

  get '/errors' => 'application#error'

  end
