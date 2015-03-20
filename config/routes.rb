Rails.application.routes.draw do
  devise_for :users
  
  root 'application#home'

  resources :lifelines, only: :create

  end
