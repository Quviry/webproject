# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "home/index"

  get "/signup", to: "user#new", as: "register"
  post "/signup", to: "user#create"

  get "/login", to: "session#new", as: "login"
  post "/login", to: "session#create"
  get "/logout", to: "session#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
