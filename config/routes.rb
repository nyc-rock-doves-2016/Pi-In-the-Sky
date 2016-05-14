Rails.application.routes.draw do

  root 'global_data_objects#index'

  resources :global_data_objects


  get "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create", as: "new_login"

  resources :users, only: [:show, :new, :create]


end
