Rails.application.routes.draw do
  root "homes#top"
  get "home/about", to: "homes#about", as: :about

  get "users/sign_up", to: "registrations#new", as: :new_user

 resource :user_registration,
         only: %i[new create],
         controller: "registrations",
         path: "users",
         path_names: { new: "sign_up" }

resources :users, except: %i[new create]

  resources :books

  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check
end