Shiita::Application.routes.draw do

  email_constraints = { email: /[^\/]+/ }

  resources :items do
    member do
      post "stock"
      delete "stock" => :unstock
      post "comment"
    end
  end

  controller :tags do
    get "/tags" => :index, as: :tags
    get "/tags/:name" => :show, as: :tag
    post "/tags/:name/follow" => :follow, as: :tag_follow
    delete "/tags/:name/follow" => :unfollow, as: :tag_follow
    get "/tags/:name/followers" => :followers, as: :tag_followers
  end

  controller :users do
    get "/users" => :index, as: :users
    get "/users/:email" => :show, as: :user, constraints: email_constraints
    post "/users/:email/follow" => :follow, as: :user_follow, constraints: email_constraints
    delete "/users/:email/follow" => :unfollow, as: :user_follow, constraints: email_constraints
    get "/users/:email/stocks" => :stocks, as: :user_stocks, constraints: email_constraints
    get "/users/:email/followings" => :followings, as: :user_followings, constraints: email_constraints
    get "/users/:email/followers" => :followers, as: :user_followers, constraints: email_constraints
  end

  controller :sessions do
    get "/login" => redirect("/auth/google_oauth2"), as: :login
    get '/auth/:provider/callback' => :callback
    delete '/logout' => :destroy, as: :logout
  end

  %w(about help).each do |name|
    get "/#{name}" => "home#help"
  end

  root to: "home#index"

end
