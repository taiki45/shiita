Shiita::Application.routes.draw do

  email_constraints = { email: /[^\/]+/ }

  resources :items

  get "/tags/:name" => "tags#show", as: :tag
  get "tags/:name/follow" => "tags#follow", as: :tag_follow

  get "/users/:email" => "users#show", as: :user, constraints: email_constraints
  get "users/:email/follow" => "users#follow", as: :user_follow, constraints: email_constraints

  get "/login" => redirect("/auth/google_oauth2"), as: :login
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: "sessions#destroy"
  get '/local_login', to: "sessions#local_login"

  root to: "home#index"

end
