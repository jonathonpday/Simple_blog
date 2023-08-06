Rails.application.routes.draw do
resources :registrations, only: [:new, :create]
resources :logins, only: [:new, :create]
resources :posts, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root"registrations#new"
end
