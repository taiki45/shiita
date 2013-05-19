Shiita::Application.routes.draw do

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

    scope "/users/:email", constraints: { email: /[^\/]+/ } do
      get "" => :show, as: :user
      post "/follow" => :follow, as: :user_follow
      delete "/follow" => :unfollow
      get "/stocks" => :stocks, as: :user_stocks
      get "/followings" => :followings, as: :user_followings
      get "/followers" => :followers, as: :user_followers
    end
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
