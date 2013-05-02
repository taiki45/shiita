Shiita::Application.routes.draw do

  email_constraints = { email: /[^\/]+/ }

  resources :items
  controller :items do
    get "/items/:id/stock" => :stock, as: :item_stock
  end

  controller :tags do
    get "/tags" => :index, as: :tags
    get "/tags/:name" => :show, as: :tag
    get "/tags/:name/follow" => :follow, as: :tag_follow
  end

  controller :users do
    get "/users" => :index, as: :users
    get "/users/:email" => :show, as: :user, constraints: email_constraints
    get "/users/:email/follow" => :follow, as: :user_follow, constraints: email_constraints
  end

  controller :sessions do
    get "/login" => redirect("/auth/google_oauth2"), as: :login
    get '/auth/:provider/callback' => :callback
    get '/logout' => :destroy, as: :logout
    get '/local_login' => :local_login
  end

  %w(about help).each do |name|
    get "/#{name}" => "home#help"
  end

  root to: "home#index"

end
