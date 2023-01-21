# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "home/index"

  get "/signup", to: "user#new", as: "register"
  post "/signup", to: "user#create"

  get "/login", to: "session#new", as: "login"
  post "/login", to: "session#create"
  get "/logout", to: "session#destroy"

  get "/comics", to: "series#comics"
  get "/novels", to: "series#novels"

  get "/series/:title", to: "series#show", as: "series" # attention
  get "/series/:title/info", to: "series#info", as: "series_info"

  get "/episode/:id", to: "episode#show", as: "episode"

  get "/dashboard", to: "dashboard#index"
  get "/dashboard/series/new", to: "series#new"
  post "/dashboard/series/new", to: "series#create"
  get "/dashboard/series/:id/edit", to: "series#edit", as: "edit_series"
  patch "/dashboard/series/:id", to: "series#update", as: "update_series"
  delete "/dashboard/series/:id", to: "series#destroy", as: "destroy_series"

  get "/dashboard/series/:series_id/episode/create", to: "episode#new", as: "new_episode"
  post "/dashboard/series/:series_id/episode/create", to: "episode#create"

  get "/dashboard/series/:series_id/episode/list", to: "episode#index", as: "episodes"

  get "/user/:id", to: "user#show", as: "user"
end
