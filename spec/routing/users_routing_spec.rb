require "spec_helper"

describe UsersController do
  describe "routing" do

    describe "constrains" do
      it "routes with dot containing email" do
        get("/users/test.1").should route_to("users#show", email: "test.1")
      end

      it "routes with minus containing email" do
        get("/users/test-1").should route_to("users#show", email: "test-1")
      end
    end

    it "routes to #show" do
      get("/users/test").should route_to("users#show", email: "test")
    end

    it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #index with pagination" do
      get("/users/page/1").should route_to("users#index", page: "1")
    end

    it "routes to #follow" do
      post("/users/test/follow").should route_to("users#follow", email: "test")
    end

    it "doesn't route to #follow with get" do
      get("/users/test/follow").should_not route_to("users#follow", email: "test")
    end

    it "routes to #unfollow with delete" do
      delete("/users/test/follow").should route_to("users#unfollow", email: "test")
    end

    it "routes to #stocks" do
      get("/users/test/stocks").should route_to("users#stocks", email: "test")
    end

    it "routes to #stocks with pagination" do
      get("/users/test/stocks/1").should route_to("users#stocks", email: "test", page: "1")
    end

    it "routes to #followings" do
      get("/users/test/followings").should route_to("users#followings", email: "test")
    end

    it "routes to #followers" do
      get("/users/test/followers").should route_to("users#followers", email: "test")
    end

  end
end
