Rails.application.routes.draw do
  root "homes#top"
  get "home/about", to: "homes#about", as: :about
  get "search", to: "searches#search", as: :search
  get "users/sign_up", to: "registrations#new", as: :new_user
 
  resources :groups, only: [:index, :new, :create, :show, :edit, :update] do
  resource :group_user, only: [:create, :destroy]
   resource :event, only: [:new, :create], controller: "group_events"
end
 resource :user_registration,
         only: %i[new create],
         controller: "registrations",
         path: "users",
         path_names: { new: "sign_up" }

         resources :users, except: %i[new create] do
    resource :relationships, only: [:create, :destroy]

    get "followings",
      to: "relationships#followings",
      as: :followings

    get "followers",
      to: "relationships#followers",
      as: :followers
end

resources :books do
  resource :favorite, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
end

  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check
end