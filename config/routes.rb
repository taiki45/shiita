Shiita::Application.routes.draw do

  resources :items

  get "/tags/:name" => "tags#show", as: :tag
  get "/users/:email" => "users#show", as: :user

  get "/login" => redirect("/auth/google_oauth2"), as: :login
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: "sessions#destroy"
  get '/local_login', to: "sessions#local_login"

  root to: "home#index"

end
