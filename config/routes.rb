Shiita::Application.routes.draw do

  resources :items

  match "/tags/:name" => "tags#show", as: :tag
  match "/users/:email" => "users#show", as: :user

  match '/auth/:provider/callback', to: 'sessions#callback'
  get 'logout', to: "sessions#destroy"
  get 'local_login', to: "sessions#local_login"

  root to: "home#index"

end
