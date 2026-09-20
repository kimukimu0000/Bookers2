Rails.application.routes.draw do
  root "homes#top"
  get "home/about", to: "homes#about", as: :about

  resources :users
  resources :books

  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check
end