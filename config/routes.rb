Shiita::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#callback'
  get 'logout', to: "sessions#destroy"

  root to: "home#index"

end
