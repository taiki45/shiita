Shiita::Application.routes.draw do

  resources :items


  get "/users/:email", to: "users#show"

  match '/auth/:provider/callback', to: 'sessions#callback'
  get 'logout', to: "sessions#destroy"
  get 'local_login', to: "sessions#local_login"

  root to: "home#index"

end
