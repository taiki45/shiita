Shiita::Application.routes.draw do

  resources :items do
    get 'page/:page', :action => :index, :on => :collection

    member do
      post "stock"
      delete "stock" => :unstock
      post "comment"
    end
  end

  scope "tags", controller: :tags do
    get "" => :index, as: :tags

    scope ":name" do
      get "" => :show, as: :tag
      get "followers" => :followers, as: :followers_tag
      post "follow" => :follow, as: :follow_tag
      delete "follow" => :unfollow
    end
  end

  scope "users", controller: :users do
    get "" => :index, as: :users

    scope ":email", constraints: { email: /[^\/]+/ } do
      get "" => :show, as: :user
      get "stocks" => :stocks, as: :stocks_user
      get "followings" => :followings, as: :followings_user
      get "followers" => :followers, as: :followers_user
      post "follow" => :follow, as: :follow_user
      delete "follow" => :unfollow
    end
  end

  controller :sessions do
    get "/login" => redirect("/auth/google_oauth2"), as: :login
    get '/auth/:provider/callback' => :callback
    delete '/logout' => :destroy, as: :logout
  end

  controller :home do
    get "/help" => :help
    get "/search" => :search
  end

  root to: "home#index"

end
