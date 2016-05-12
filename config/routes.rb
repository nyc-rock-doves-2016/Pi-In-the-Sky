Rails.application.routes.draw do

  root 'welcome#index'


  get "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  post "login" => "sessions#create", as: "new_login"

  resources :users, only: [:show, :new, :create]


end
